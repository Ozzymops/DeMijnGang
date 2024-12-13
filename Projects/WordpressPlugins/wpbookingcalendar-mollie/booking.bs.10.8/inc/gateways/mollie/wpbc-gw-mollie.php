<?php
/**
 * @package Mollie Integration
 * @category Payment Gateway for Booking Calendar 
 * @author Justin Muris
 * @version 1.0
 * @modified 2024-12-06
 *
 * Integration based on Stripe implementation
 * Based on guide: https://wpbookingcalendar.com/faq/
 *
 */

//FixIn: 8.4.7.20

if (!defined('ABSPATH')) exit;
if (!defined('WPBC_MOLLIE_GATEWAY_ID')) define('WPBC_MOLLIE_GATEWAY_ID', 'mollie');

class WPBC_Gateway_API_MOLLIE extends WPBC_Gateway_API {
	public function get_payment_form($output, $params, $gateway_id = '') {
		if ((!empty($gateway_id) && ($gateway_id !== $this->get_id())) || $this->is_gateway_on()) return $output;

		// configuration
		$payment_options = array();
		$payment_options['subject'] = get_bk_option('booking_mollie_subject');
		$payment_options['subject'] = wpbc_lang($payment_options['subject']);
		$payment_options['subject'] = wpbc_replace_booking_shortcodes($payment_options['subject'], $params);
		$payment_options['subject'] = substr($payment_options['subject'], 0, 499);
		$payment_options['payment_methods'] = get_bk_option('booking_mollie_payment_methods');
		$payment_options['payment_mode'] = get_bk_option('booking_mollie_payment_mode');
		$payment_options['payment_button_title'] = get_bk_option('booking_mollie_payment_button_title');
		$payment_options['payment_button_title'] = wpbc_lang($payment_options['payment_button_title']);
		$payment_options['account_mode'] = get_bk_option('booking_mollie_account_mode');
		$payment_options['curency'] = get_bk_option('booking_mollie_curency'); // typo is intentional?
		$edit_url_for_visitors = get_bk_option('booking_url_bookings_edit_by_visitors');

		if ($payment_options['account_mode'] == 'test') { $payment_options['publishable_key'] = get_bk_option('booking_mollie_publishable_key_test'); }
		else { $payment_options['publishable_key'] = get_bk_option('booking_mollie_publishable_key'); }

		// secret key
		$mollie_account_mode = get_bk_option('booking_mollie_account_mode');
		if ($mollie_account_mode == 'test') { $payment_options['secret_key'] = get_bk_option('booking_mollie_secret_key_test'); }
		else { $payment_options['secret_key'] = get_bk_option('booking_mollie_secret_key'); }
	
		// check
		if (empty($payment_options['curency'])) { return 'Wrong configuration in gateway settings.' . ' <em>Empty: "Currency" option</em>'; }
		if (empty($payment_options['publishable_key'])) { return 'Wrong configuration in gateway settings.' . ' <em>Empty: "Publishable Key" option</em>'; }
		if (empty($payment_options['secret_key'])) { return 'Wrong configuration in gateway settings.' . ' <em>Empty: "Secret Key" option</em>'; }
		if (site_url() == $edit_url_for_visitors) { return 'Mollie requires correct configuration ' . ' <em>"URL to edit bookings" option</em>'; }
		if (version_compare(PHP_VERSION, '5.6') < 0) { return 'Mollie payment requires PHP version 5.6 or newer.'; }
		if (!class_exists('Mollie/Mollie')) { require_once(dirname(__FILE__) . '/Mollie/vendor/autoload.php'); }

		// approve/decline url
		$hash_approve = wpbc_get_secret_hash(array('payment', WPBC_MOLLIE_GATEWAY_ID, $params['bookinghash'], 'approve'));
		$hash_decline = wpbc_get_secret_hash(array('payment', WPBC_MOLLIE_GATEWAY_ID, $params['bookinghash'], 'decline'));
		$payment_options['success_url'] = wpbc_get_1way_hash_url($hash_approve);
		$payment_options['error_url'] = wpbc_get_1way_hash_url($hash_decline);

		// cost
		$check_currency = strtolower($payment_options['curency']);
		$is_cents = wpbc_mollie__cents_factor($check_currency);

		$currency_minimum = array(
			'usd' => 0.50,
			'eur' => 0.50
		);

		foreach($currency_minimum as $min_currency => $min_currency_value) {
			if (($min_currency == $check_currency) && (floatval($params['cost_in_gateway']) * $is_cents < floatval($min_currency_value) * $is_cents)) { return '<strong>' . __('Error', 'booking') . '</strong>!' . 'Mollie requires minimum amount in this currency as ' . '<strong>' . strtoupper($min_currency) . '</strong> ' . '<strong>' . $min_currency_value . '</strong>'; }
		}

		// backend
		$mollie = new \Mollie\Api\MollieApiClient();
		$mollie->setApiKey($payment_options['secret_key']);

		if (empty($payment_options['payment_methods']) || ($payment_options['payment_methods'] == 'card')) { $payment_options['payment_methods'] = array('card'); }

		// TODO: rewrite based on api docs
		$mollie_session_params = array(
			'success_url' => esc_url_raw($payment_options['success_url']),
			'cancel_url' => esc_url_raw($payment_options['error_url']),
			'mode' => 'payment',
			'payment_method_types' => $payment_options['payment_methods'],
			'client_reference_id' => $params['bookinghash'],
			'line_items' => array()
		);

		if ($payment_options['payment_mode'] === 'setup') { $mollie_session_params['mode'] = 'setup'; }
		if ($mollie_session_params['mode'] != 'setup') { $mollie_session_params['payment_intent_data'] = array('description' => 'Booking #' . $params['booking_id'] . '. ' . substr($payment_options['subject'], 0, 255), 'metadata' => array('booking_id' => $params['booking_id'], 'booking_description' => substr($payment_options['subject'], 0, 255))); }

		// billing details
		if (($mollie_session_params['mode'] == 'payment') || ($mollie_session_params['mode'] == 'setup')) {
			$mollie_session_params['customer_creation'] = 'always';
			$mollie_session_params['payment_intent_data']['setup_future_usage'] = 'off_session';
		}

		$mollie__customer__arr = array();
		if ($mollie_session_params['mode'] == 'setup') {
			// email
			$billing_field_name = (string)trim(get_bk_option('booking_billing_customer_email'));
			if (!empty($params[$billing_field_name])) { $mollie__customer__arr['email'] = $params[$billing_field_name]; }
			if (empty($mollie__customer__arr['email']) && !empty($params['email'])) { $mollie__customer__arr['email'] = $params['email']; }

			// name
			$billing_field_name = (string)trim(get_bk_option('booking_billing_firstnames')); // again, typo intentional?
			if (isset($params[$billing_field_name])) { $mollie__customer__arr['name'] = $params[$billing_field_name]; }

			$billing_field_name = (string)trim(get_bk_option('booking_billing_surname'));
			if (isset($params[$billing_field_name])) {
				$mollie__customer__arr['name'] .= (empty($mollie__customer__arr['name'])) ? '' : ' ';
				$mollie__customer__arr['name'] .= $params[$billing_field_name];
			}

			// phone
			$billing_field_name = (string)trim(get_bk_option('booking_billing_phone'));
			if (isset($params[$billing_field_name])) { $mollie__customer__arr['phone'] = $params[$billing_field_name]; }

			// address
			$mollie__customer__arr['address'] = array();
			$billing_field_name = (string)trim(get_bk_option('booking_billing_address1'));
			if (isset($params[$billing_field_name])) { $mollie__customer__arr['address']['line1'] = $params[$billing_field_name]; }

			$billing_field_name = (string)trim(get_bk_option('booking_billing_city'));
			if (isset($params[$billing_field_name])) { $mollie__customer__arr['address']['city'] = $params[$billing_field_name]; }

			$billing_field_name = (string)trim(get_bk_option('booking_billing_country'));
			if (isset($params[$billing_field_name])) { $mollie__customer__arr['address']['country'] = $params[$billing_field_name]; }

			$billing_field_name = (string)trim(get_bk_option('booking_billing_post_code'));
			if (isset($params[$billing_field_name])) { $mollie__customer__arr['address']['postal_code'] = $params[$billing_field_name]; }

			$billing_field_name = (string)trim(get_bk_option('booking_billing_state'));
			if (isset($params[$billing_field_name])) { $mollie__customer__arr['address']['state'] = $params[$billing_field_name]; }

			// create customer
			if (!empty($mollie__customer__arr)) {
				try {
					$customer_response = $mollie->customers->create($mollie__customer__arr); // TODO: rewrite based on api docs
					if (!empty($customer_response) && !empty($customer_response->id)) { $mollie_session_params['customer'] = $customer_response->id; }
				}
				catch (Exception $e) {
					return 'Caught exception: ' . $e->getMessage();
				}
			}
		}

		if (empty($mollie_session_params['customer'])) {
			if (!empty($params['email'])) { $mollie_session_params['customer_email'] = $params['email']; }
		}

		// payment
		// TODO: rewrite based on api docs
		$mollie_item = array();
		$mollie_item['quantity'] = 1;
		$mollie_item['price_data'] = array();
		$mollie_item['price_data']['currency'] = $payment_options['curency'];
		$mollie_item['price_data']['unit_amount'] = wpbc_mollie__amount_in_mollie($params['cost_in_gateway'], $payment_options['curency']);
		$mollie_item['price_data']['product_data'] = array();
		$mollie_item['price_data']['product_data']['name'] = 'Booking #' . $params['booking_id'];
		$mollie_item['price_data']['product_data']['description'] = substr($payment_options['subject'], 0, 255);

		if ($mollie_session_params['mode'] != 'setup') { $mollie_session_params['line_items'][] = $mollie_item; }

		try {
			$session_response = $mollie->checkout->sessions->create($mollie_session_params);
		}
		catch (Exception $e) {
			return 'Caught exception: ' . $e->getMessage();
		}

		// frontend
		ob_start();
		// TODO: rewrite based on api docs
		?><div class="mollie_div wpbc-replace-ajax wpbc-payment-form" style="text-align: left; clear: both;">
		<div style="display: none;"><ajax_script src="https://js.stripe.com/v3/"></ajax_script></div><?php

		$is_immediate_redirection = false;

		if (!$is_immediate_redirection) {
			?><div style="display: none;">
			<ajax_script>
				var wpbc_mollie_payment = (function() {
					var mollie_publish_key = "<?php echo $payment_options['publishable_key']; ?>";
					var mollie_session = "<?php echo $session_response->id; ?>";
					return function mollie_check_out(){
						var mollie = Mollie(mollie_publish_key);
						mollie.redirectToCheckout({
							sessionId: mollie_session
						}).then(function(result) {
							console.log(result.error.message);
						});
					}
				})();
			</ajax_script>
			</div>
			<a class="wpbc_button_light wpbc_button_gw wpbc_button_gw_mollie" href="javascript:void(0)" onclick="javascript:wpbc_mollie_payment();"><?php echo trim($payment_options['payment_button_title']); ?></a><?php
		} else {
			?><ajax_script>
				setTimeout(function() {
					var mollie = Mollie('<?php echo $payment_options['publishable_key']; ?>');
					mollie.redirectToCheckout({
						sessionId: '<?php echo $session_response->id; ?>'
					}).then(function (result) {
						console.log(result.error.message);
					});
				}, 1500);
		</ajax_script><?php
		}
		?></div><?php

		$payment_form = ob_get_clean();
		return $output . $payment_form;
	}

	public function init_settings_fields() {
		$this->fields = array();
		
		$this->fields['is_active'] = array(
			'type' => 'checkbox',
			'default' => 'On',
			'title' => __('Enable / Disable', 'booking'),
			'label' => __('Enable this payment gateway', 'booking'),
			'description' => '',
			'group' => 'general'
		);

		$this->fields['account_mode'] = array(
			'type' => 'radio',
			'default' => 'test',
			'title' => __('Choose payment account', 'booking'),
			'description' => '',
			'description_tag' => 'span',
			'css' => '',
			'options' => array(
				'test' => array('title' => __('TEST', 'booking'), 'attr' => array('id' => 'mollie_mode_test')),
				'live' => array('title' => __('LIVE', 'booking'), 'attr' => array('id' => 'mollie_mode_live'))
				),
			'group' => 'general'
		);

		$this->fields['publishable_key'] = array(
			'type' => 'text',
			'default' => (wpbc_is_this_demo() ? 'TEST KEY HERE' : ''),
			'title' => __('Publishable key', 'booking'),
			'description' => __('Required', 'booking') . '.<br/>' . sprintf(__('This parameter has to be assigned by %s', 'booking'), 'Mollie') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
			'description_tag' => 'span',
			'css' => '',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_grayed wpbc_sub_settings_mode_live'
		);

		$this->fields['secret_key'] = array(
			'type' => 'text',
			'default' => (wpbc_is_this_demo() ? 'SECRET KEY HERE' : ''),
			'title' => __('Secret key', 'booking'),
			'description' => __('Required', 'booking') . '.<br/>' . sprintf(__('This parameter has to be assigned by %s', 'booking'), 'Mollie') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
			'description_tag' => 'span',
			'css' => '',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_grayed wpbc_sub_settings_mode_live'
		);

		$this->fields['publishable_key_test'] = array(
			'type' => 'text',
			'default' => (wpbc_is_this_demo() ? 'TEST KEY HERE' : ''),
			'title' => __('Publishable key', 'booking') . ' (' . __('TEST', 'booking') . ')',
			'description' => __('Required', 'booking') . '.<br/>' . sprintf(__('This parameter has to be assigned by %s', 'booking'), 'Mollie') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
			'description_tag' => 'span',
			'css' => '',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_grayed wpbc_sub_settings_mode_test'
		);

		$this->fields['secret_key_test'] = array(
			'type' => 'text',
			'default' => (wpbc_is_this_demo() ? 'SECRET KEY HERE' : ''),
			'title' => __('Secret key', 'booking') . ' (' . __('TEST', 'booking') . ')',
			'description' => __('Required', 'booking') . '.<br/>' . sprintf(__('This parameter has to be assigned by %s', 'booking'), 'Mollie') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
			'description_tag' => 'span',
			'css' => '',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_grayed wpbc_sub_settings_mode_test'
		);

		$currency_list = array(
			'EUR' => __('Euros', 'booking'),
			'USD' => __( 'U.S. Dollars', 'booking' ),
			'GBP' => __( 'Pounds Sterling', 'booking' )
		);

		$this->fields['curency'] = array(
			'type' => 'select',
			'default' => 'EUR',
			'title' => __('Accepted currency', 'booking'),
			'description' => __('The gateway-processed currency code.', 'booking'),
			'description_tag' => 'span',
			'css' => '',
			'options' => $currency_list,
			'group' => 'general'
		);

		$payment_methods_list = array(
			'card' => __('Card', 'booking'),
			'ideal' => 'iDEAL'
		);

		$this->fields['payment_methods'] = array(
			'type' => 'select',
			'multiple' => true,
			'default' => 'EUR',
			'title' => __('Payment methods', 'booking'),
			'description' => __('Select one or several payment methods.', 'booking') . ' ' . __('Use CTRL to select multiple options.', 'booking'),
			'description_tag' => 'p',
			'css' => 'width: 100%; height: 20em;',
			'options' => $payment_methods_list,
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_payment_button_title wpbc_sub_settings_grayed'
		);

		$this->fields['payment_mode'] = array(
			'type' => 'select',
			'default' => 'payment',
			'title' => __('Payment mode', 'booking'),
			'description' => __('Accept one-time payments, or save payment details for later use.', 'booking'),
			'description_tag' => 'span',
			'css' => '',
			'option' => array(
				'payment' => __('Accept one-time payments', 'booking'),
				'setup' => __('Save payment details for later use', 'booking')
				),
			'group' => 'general'
		);

		$this->fields['payment_button_title'] = array(
			'type' => 'text',
			'default' => __('Pay via', 'booking') . ' Mollie',
			'placeholder' => __('Pay via', 'booking') . ' Mollie',
			'title' => __('Payment button title', 'booking'),
			'description' => __('Enter the title of the payment button', 'booking'),
			'description_tag' => 'p',
			'css' => 'width: 100%;',
			'group' => 'general'
		);

		$this->fields['subject'] = array(
			'type' => 'textarea',
			'default' => sprintf(__('Payment for booking %s on these day(s): %s'  ,'booking'), '[resource_title]', '[dates]'),
			'placeholder' => sprintf(__('Payment for booking %s on these day(s): %s'  ,'booking'), '[resource_title]', '[dates]'),
			'title' => __('Payment description at gateway website', 'booking'),
			'description' => sprintf(__('Enter the service name or the reason for the payment here.', 'booking'), '<br/>', '</b>') . '<br/>' .  __('You can use any shortcodes, which you have used in content of booking fields data form.', 'booking'),
			'description_tag' => 'p',
			'css' => 'width:100%',
			'rows' => 2,
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_is_description_show wpbc_sub_settings_grayedNO',
		);

		$this->fields['order_succesful_prefix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<tr valign="top" class="wpbc_tr_mollie_order_successful"><th scope="row">' . WPBC_Settings_API::label_static('mollie_order_successful', array('title' => __('Return URL after successful order', 'booking'), 'label_css' => '')) . '</th><td><fieldset><code style="font-size: 14px;">' . get_option('siteurl') . '</code',
			'tr_class' => 'relay_response_sub_class'
		);

		$this->fields['order_successful'] = array(
			'type' => 'text',
			'default' => '/successful',
			'placeholder' => '/successful',
			'css' => 'width: 75%;',
			'group' => 'auto_approve_cancel',
			'only_field' => true,
			'tr_class' => 'relay_response_sub_class'
		);

		$this->fields['order_succesful_sufix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<p class="description" style="line-height: 1.7em; margin: 0;">' . __('Return URL after completing payment.', 'booking') . '<br/>' . sprintf(__('For example, a page that displays %s"Thank you for the payment"%s.', 'booking'), '<b>', '</b>') . '</p></fieldset></td></tr>',
			'tr_class' => 'relay_response_sub_class'
		);

		$this->fields['order_failed_prefix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<tr valign="top" class="wpbc_tr_mollie_order_failed"><th scope="row">' . WPBC_Settings_API::label_static('mollie_order_failed', array('title' => __('Return URL after failed order', 'booking'), 'label_css' => '')) . '</th><td><fieldset><code style="font-size: 14px;">' . get_option('siteurl') . '</code',
			'tr_class' => 'relay_response_sub_class'
		);

		$this->fields['order_failed'] = array(
			'type' => 'text',
			'default' => '/failed',
			'placeholder' => '/failed',
			'css' => 'width: 75%;',
			'group' => 'auto_approve_cancel',
			'only_field' => true,
			'tr_class' => 'relay_response_sub_class'
		);

		$this->fields['order_failed_sufix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<p class="description" style="line-height: 1.7em; margin: 0;">' . __('Return URL after completing payment.', 'booking') . '<br/>' . sprintf(__('For example, a page that displays %s"Payment canceled"%s.', 'booking'), '<b>', '</b>') . '</p></fieldset></td></tr>',
			'tr_class' => 'relay_response_sub_class'
		);

		$this->fields['is_auto_approve_cancell_booking'] = array(
			'type' => 'checkbox',
			'default' => 'Off',
			'title' => __('Automatically approve/cancel booking', 'booking'),
			'label' => __('Check this box to automatically approve bookings, when visitors make a successful payment, or automatically cancel the booking, when visitors make a payment cancellation.', 'booking'),
			'description' => '<div class="wpbc-settings-notice notice-warning" style="text-align: left;"><strong>' . __('Warning', 'booking') . '!</strong>' . __('This will not work if the visitor leaves the payment page.', 'booking') . '</div>',
			'description_tag' => 'p',
			'group' => 'auto_approve_cancel',
			'tr_class' => 'relay_response_sub_class'
		);
	}

	public function get_gateway_info() {
		$gateway_info = array(
			'id' => $this->get_id(),
			'title' => 'Mollie',
			'currency' => get_bk_option('booking_' . $this->get_id() . '_' . 'curency'),
			'enabled' => $this->is_gateway_on()
		);

		return $gateway_info;
	}

	public function get_payment_status_array() {
		// TODO: rewrite based on api docs
		return array(
			'ok' => array('Mollie:OK'),
			'pending' => array('Mollie:Pending'),
			'unknown' => array('Mollie:Unknown'),
			'error' => array(
				'Mollie:Failed',
				'Mollie:Rejected'
				)
		);
	}

	function wpbc_mollie__cents_factor($currency) {
		$is_cents = 100;

		if (!empty($currency)) {
			$check_currency = strtolower($currency);

			if (in_array($check_currency, array('bif', 'mga', 'clp', 'djf', 'pyg', 'rwf', 'gnf', 'ugx', 'jpy', 'kmf', 'krw', 'vnd', 'vuv', 'xaf', 'xof', 'xpf'))) {
				$is_cents = 1;
			}
		}

		return $is_cents;
	}

	function wpbc_mollie__amount_in_mollie($plugin_amount, $currency) {
		$is_cents = wpbc_mollie__cents_factor($currency);
		$cents_amount = intval(floatval($plugin_amount * $is_cents));
		return $cents_amount;
	}

	function wpbc_mollie__amount_in_plugin($mollie_amount_in_cents, $currency) {
		$is_cents = wpbc_mollie__cents_factor($currency);
		return floatval($mollie_amount_in_cents / $is_cents);
	}
}

class WPBC_Settings_Page_Gateway_MOLLIE extends WPBC_Page_Structure {
	public $gateway_api = false;

	public function get_api($init_fields_values = array()) {
		if ($this->gateway_api === false) {
			$this->gateway_api = new WPBC_Gateway_API_MOLLIE(WPBC_MOLLIE_GATEWAY_ID, $init_fields_values);
		}

		return $this->gateway_api;
	}

	public function in_page() {
		if (get_bk_option('booking_super_admin_receive_regular_user_payments' == 'On') && !wpbc_is_mu_user_can_be_here('only_super_admin')) { return (string) rand(100000, 1000000); }
	
		return 'wpbc_settings';
	}
	
	public function tabs() {
		$tabs = array();
		$subtabs = array();
	
		$subtabs[WPBC_MOLLIE_GATEWAY_ID] = array(
			'type' => 'subtab',
			'title' => 'Mollie',
			'page_title' => sprintf(__('%s Settings', 'booking'), 'Mollie'),
			'hint' => sprintf(__('Integration of %s payment system', 'booking'), 'Mollie'),
			'link' => '',
			'position' => '',
			'css_classes' => '',
			'header_font_icon' => 'wpbc_icn_payment',
			'default' => false,
			'disabled' => false,
			'checkbox' => false,
			'content' => 'content',
			'is_use_left_navigation' => true,
			'show_checked_icon' => true,
			'checked_data' => 'booking_' . WPBC_MOLLIE_GATEWAY_ID . '_is_active'
		);
	
		$tabs['payment']['subtabs'] = $subtabs;
		return $tabs;
	}
	
	public function content() {
		$this->css();
		do_action('wpbc_hook_settings_page_header', 'gateway_settings');
		do_action('wpbc_hook_settings_page_header', 'gateway_settings_' . WPBC_MOLLIE_GATEWAY_ID);
	
		if (!wpbc_is_mu_user_can_be_here('activated_user')) return false;
	
		$submit_form_name = 'wpbc_gateway_' . WPBC_MOLLIE_GATEWAY_ID;
	
		echo '<span class="wpdevelop">';
		wpbc_js_for_bookings_page();
		echo '</span>';
	
		?>
		<div class="clear"></div>
		<span class="metabox-holder">
			<form name="<?php echo $submit_form_name; ?>" id="<?php echo $submit_form_name; ?>" action="" method="post" autocomplete="off">
				<?php wp_nonce_field('wpbc_settings_page_' . $submit_form_name); ?>
				<input type="hidden" name="is_form_sbmitted_<?php echo $submit_form_name; ?>" id="is_form_sbmitted_<?php echo $submit_form_name; ?>" value="1" /> <!-- Intentional typo in name? -->
				<?php
					$edit_url_for_visitors = get_bk_option('booking_url_bookings_edit_by_visitors');
					$message_type = ($edit_url_for_visitors == site_url() ? 'error' : 'warning');
				?>
				<div class="wpbc_settings-notice notice-warning notice-helpful-info">
					<div>
						<strong><?php _e('Note!', 'booking'); ?></strong><strong style="padding-left: 10px;">1. </strong>
						<?php printf(__('If you have no account on this system, please visit %s to create one.', 'booking'), '<a href="https://mollie.com" target="_blank" style="text-decoration: none;">Mollie</a>'); ?>
					</div>
					<div style="padding-left: 42px;">
						<strong>2. <?php echo (($message_type == 'error') ? __('Error', 'booking') . '! ' : ''); ?></strong>
						<?php
							echo 'Mollie ';
							printf(__('Requires correct configuration of this option: %sURL to edit bookings%s', 'booking'), '<strong><a href="https://wpbookingcalendar.com/faq/configure-editing-cancel-payment-bookings-for-visitors/#content">', '</a></strong>.');
						?>
					</div>
					<div style="padding-left: 42px;">
						<strong>3. </strong>
						<?php printf(__('You may test your integration over HTTP. However, live integrations must use HTTPS.', 'booking'), '<strong>', '</strong>', '<strong>', '</strong>'); ?>
					</div>
				</div>
				<div class="clear"></div>
				<?php
					if (version_compare(PHP_VERSION, '5.6') < 0) {
						echo '';
						?>
						<div class="wpbc-settings-notice notice-error" style="text-align: left;">
							<strong><?php _e('Error', 'booking'); ?></strong>! <?php printf(__('Mollie requires PHP version %s or newer!', 'booking'), '<strong>5.6</strong>'); ?>
						</div>
						<?php
					}
	
					if (!function_exists('curl_init') && !wpbc_is_this_demo()) {
						?>
						<div class="clear" style="height: 5px;"></div>
						<div class="wpbc-settings-notice notice-error" style="text-align: left;">
							<strong><?php _e('Error', 'booking'); ?></strong>! <?php printf('Mollie requires PHP CURL library!', '<strong>' . PHP_VERSION . '</strong>'); ?>
						</div>
						<div class="clear" style="height: 5px;"></div>
						<?php
					}
				?>
				<div class="clear"></div>
				<div class="metabox-holder">
					<div class="wpbc_settings_row wpbc_settings_row_left_NO">
						<?php
							wpbc_open_meta_box_section($submit_form_name . 'general' . 'Mollie');
							$this->get_api()->show('general');
							wpbc_close_meta_box_section();
						?>
					</div>
					<div class="clear"></div>
					<div class="wpbc_settings_row wpbc_settings_row_left_NO">
						<?php
							wpbc_open_meta_box_section($submit_form_name . 'auto_approve_cancel' . __('Advanced', 'booking'));
							$this->get_api()->show('auto_approve_cancel');
							wpbc_close_meta_box_section();
						?>
					</div>
					<div class="clear"></div>
				</div>
				<input type="submit" value="<?php _e('Save changes', 'booking'); ?>" class="button button-primary" />
			</form>
		</span>
		<?php
	
		$this->enqueue_js();
	}
	
	public function maybe_update() {
		$init_fields_values = array();
		$submit_form_name = 'wpbc_gateway_' . WPBC_MOLLIE_GATEWAY_ID;
		$this->get_api($init_fields_values);
		$this->get_api()->validated_form_id = $submit_form_name;
	
		if (isset($_POST['is_form_sbmitted' . $submit_form_name])) {
			$nonce_gen_time = check_admin_referer('wpbc_settings_page_' . $submit_form_name);
			$this->update();
		}
	}
	
	public function update() {
		$validated_fields = $this->get_api()->validate_post();
		$validated_fields = apply_filters('wpbc_gateway_mollie_validate_fields_before_saving', $validated_fields);
		$this->get_api()->save_to_db($validated_fields);
		wpbc_show_message(__('Settings saved.', 'booking'), 5);
	}
	
	private function css() {
		?>
		<style type="text/css">
			.wpbc-help-message {
				border: none;
				margin: 0 !important;
				padding: 0 !important;
			}
			@media (max-width: 399px) {
	
			}
		</style>
		<?php
	}
	
	private function enqueue_js() {
		$js_script = '';
	
		$js_script .= "
			if (!jQuery('#mollie_mode_test').is(':checked')) {
				jQuery('.wpbc_sub_settings_mode_test').addClass('hidden_items');
			}
	
			if (!jQuery('#mollie_mode_live').is(':checked')) {
				jQuery('.wpbc_sub_settings_mode_live').addClass('hidden_items');
			}
		";
	
		$js_script .= "
			jQuery('input[name=\"mollie_account_mode\"]').on('change', function(){
				jQuery('.wpbc_sub_settings_mode_test, .wpbc_sub_settings_mode_live').addClass('hidden_items');
				if (jQuery('#mollie_mode_test').is(':checked')) {
					jQuery('.wpbc_sub_settings_mode_test').removeClass('hidden_items');
				} else {
					 jQuery('.wpbc_sub_settings_mode_live').removeClass('hidden_items');
				}
			} );
		";
	
		$js_script .= "
			jQuery('select[name=\"mollie_curency\"]').on('change', function() {
				var wpbc_selected_p_mode = jQuery('select[name=\"mollie_curency\"] option:selected').val();
	
				if (wpbc_selected_p_mode == 'EUR') {
					jQuery('#mollie_payment_methods option').prop('disabled', false);
					jQuery('#mollie_payment_methods option').removeClass('hidden_items');
				} else {
					 jQuery('#mollie_payment_methods').find('option').prop('selected', false);
					jQuery('#mollie_payment_methods option:eq(0)').prop('selected', true);
	
					for (var i = 2; i < 9; i++) {
						jQuery('#mollie_payment_methods option:eq(' + i + ')' ).prop('disabled', true);
					}
	
					jQuery('#mollie_payment_methods option:disabled').addClass('hidden_items');
				}
			} );
		";
	
		wpbc_enqueue_js($js_script);
	}
}
add_action('wpbc_menu_created', array(new WPBC_Settings_Page_Gateway_MOLLIE(), '__construct'));
	
function wpbc_gateway_mollie_validate_fields_before_saving__all($validated_fields) {
	if ($validated_fields['is_active' == 'On']) {
		update_bk_option('booking_mollie_is_active', 'Off');
	}

	$validated_fields['order_successful'] = wpbc_make_link_relative($validated_fields['order_successful']);
	$validated_fields['order_failed'] = wpbc_make_link_relative($validated_fields['order_failed']);

	if (wpbc_is_this_demo()) {
		$validated_fields['publishable_key'] = 'PK';
		$validated_fields['secret_key'] = 'SK';
		$validated_fields['publishable_key_test'] = 'PKT';
		$validated_fields['secret_key_test'] = 'SKT';
		$validated_fields['account_mode'] = 'test';
	}

	return $validated_fields;
}
add_filter('wpbc_gateway_mollie_validate_fields_before_saving', 'wpbc_gateway_mollie_validate_fields_before_saving__all', 10, 1);

function wpbc_booking_check_previous_MOLLIE_option($option_name, $default_value) {
	$op_prefix = 'booking_' . 'mollie' . '_';
	$previous_version_value = get_bk_option($op_prefix . $option_name);

	if ($previous_version_value === false) {
		return $default_value;
	} else {
		return $previous_version_value;
	}
}

function wpbc_booking_activate_MOLLIE() {
	$op_prefix = 'booking_' . WPBC_MOLLIE_GATEWAY_ID . '_';

	add_bk_option($op_prefix . 'is_active', wpbc_is_this_demo() || wpbc_is_this_beta() ? 'On' : wpbc_booking_check_previous_MOLLIE_option('is_active', 'Off'));
	add_bk_option($op_prefix . 'account_mode', wpbc_booking_check_previous_MOLLIE_option('account_mode', 'test'));
	add_bk_option($op_prefix . 'publishable_key', wpbc_is_this_demo() || wpbc_is_this_beta() ? 'PK' : wpbc_booking_check_previous_MOLLIE_option('publishable_key', ''));
	add_bk_option($op_prefix . 'secret_key', wpbc_is_this_demo() || wpbc_is_this_beta() ? 'SK' : wpbc_booking_check_previous_MOLLIE_option('secret_key', ''));
	add_bk_option($op_prefix . 'publishable_key_test', wpbc_is_this_demo() || wpbc_is_this_beta() ? 'PKT' : wpbc_booking_check_previous_MOLLIE_option('publishable_key_test', ''));
	add_bk_option($op_prefix . 'secret_key_test', wpbc_is_this_demo() || wpbc_is_this_beta() ? 'SKT' : wpbc_booking_check_previous_MOLLIE_option('secret_key_test', ''));
	add_bk_option($op_prefix . 'curency', wpbc_booking_check_previous_MOLLIE_option('curency', 'EUR'));
	add_bk_option($op_prefix . 'payment_methods', 'ideal');
	add_bk_option($op_prefix . 'payment_mode', 'payment');
	add_bk_option($op_prefix . 'payment_button_title', wpbc_booking_check_previous_MOLLIE_option('payment_button_title', __('Pay via', 'booking') . ' Mollie'));
	add_bk_option($op_prefix . 'subject', wpbc_booking_check_previous_MOLLIE_option('subject', sprintf(__('Payment foor booking %s on these day(s): %s', 'booking'), '[resource_title]', '[dates]')));
	add_bk_option($op_prefix . 'order_successful', wpbc_booking_check_previous_MOLLIE_option('order_succesful', '/successful'));
	add_bk_option($op_prefix . 'order_failed', wpbc_booking_check_previous_MOLLIE_option('order_failed', '/failed'));
	add_bk_option($op_prefix . 'is_auto_approve_cancell_booking', wpbc_booking_check_previous_MOLLIE_option('is_auto_approve_cancell_booking', 'Off'));
}
add_bk_action('wpbc_other_versions_activation', 'wpbc_booking_activate_MOLLIE');

function wpbc_booking_deactive_MOLLIE() {
	$op_prefix = 'booking_' . WPBC_MOLLIE_GATEWAY_ID . '_';

	delete_bk_option($op_prefix . 'is_active');
	delete_bk_option($op_prefix . 'account_mode');
	delete_bk_option($op_prefix . 'publishable_key');
	delete_bk_option($op_prefix . 'secret_key');
	delete_bk_option($op_prefix . 'publishable_key_test');
	delete_bk_option($op_prefix . 'secret_key_test');
	delete_bk_option($op_prefix . 'curency');
	delete_bk_option($op_prefix . 'payment_methods');
	delete_bk_option($op_prefix . 'payment_mode');
	delete_bk_option($op_prefix . 'payment_button_title');
	delete_bk_option($op_prefix . 'subject');
	delete_bk_option($op_prefix . 'order_successful');
	delete_bk_option($op_prefix . 'order_failed');
	delete_bk_option($op_prefix . 'is_auto_approve_cancell_booking');
}
add_bk_option('wpbc_other_versions_deactivation', 'wpbc_booking_deactive_MOLLIE');

add_filter('wpbc_get_gateway_payment_form', array(new WPBC_Gateway_API_MOLLIE(WPBC_MOLLIE_GATEWAY_ID), 'get_payment_form'), 10, 3);

function wpbc_mollie_update_payment_status($booking_id, $status) {
	do_action('wpbc_booking_change_payment_status', 'mollie', $status, $booking_id);
	do_action('wpbc_mollie_update_payment_status', $booking_id, $status);

	global $wpdb;

	$update_sql = $wpdb->prepare("UPDATE {$wpdb->prefix}booking AS bk SET bk.pay_status = %s WHERE bk.booking_id = %d;", $status, $booking_id);

	if ($wpdb->query($update_sql) === false) {
		return false;
	}

	return true;
}

function wpbc_mollie_auto_cancel_booking($booking_id, $mollie_error_code) {
	$auto_approve = get_bk_option('booking_mollie_is_auto_approve_cancell_booking');

	if ($auto_approve == 'On') {
		wpbc_auto_cancel_booking__after_payment($booking_id);
	}

	$mollie_error_url = get_bk_option('booking_mollie_order_failed');
	$mollie_error_url = wpbc_make_link_absolute($mollie_error_url);

	wpbc_redirect($mollie_error_url . "?error=" . $mollie_error_code);
}

function wpbc_mollie_auto_approve_booking($booking_id, $paid_amount_in_plugin) {
	$auto_approve = get_bk_option('booking_mollie_is_auto_approve_cancell_booking');

	if ($auto_approve == 'On') {
		wpbc_auto_approve_booking__after_payment($booking_id);
	}

	$mollie_success_url = get_bk_option('booking_mollie_order_successful');

	if (empty($mollie_success_url)) {
		$mollie_success_url = get_bk_option('booking_thank_you_page_URL');
	}

	list($booking_hash, $resource_id) = wpbc_hash__get_booking_hash__resource_id($booking_id);

	$mollie_success_url = wpbc_make_link_absolute($mollie_success_url);
	$mollie_success_url .= (strpos($mollie_success_url, '?') === false ? '?' : '&') . 'paid_amount=' . $paid_amount_in_plugin;
	$mollie_success_url .= '&booking_hash=' . $booking_hash;
	$mollie_success_url .= '&is_show_payment_form=Off';

	wpbc_redirect($mollie_success_url);
}

function wpbc_payment_response__mollie($parsed_response) {
	list($response_type, $response_source, $booking_hash, $response_action) = $parsed_response;

	if ($response_type === 'payment' && $response_source === WPBC_MOLLIE_GATEWAY_ID) {
		if (class_exists('wpdev_bk_multiuser')) {
			if (!empty($booking_hash)) {
				$my_booking_id_type = wpbc_hash__get_booking_id__resource_id($booking_hash);

				if (!empty($my_booking_id_type)) {
					list($booking_id, $booking_resource_id) = $my_booking_id_type;
					$user_id = apply_bk_filter('get_user_of_this_bk_resource', false, $booking_resource_id);
					$is_booking_resource_user_super_admin = apply_bk_filter('is_user_super_admin', $user_id);

					if (get_bk_option('booking_super_admin_receive_regular_user-payments' == 'On')) {
						$is_booking_resource_user_super_admin = true;
						make_bk_action('make_force_using_this_user', -999);
					}

					if (!$is_booking_resource_user_super_admin) {
						make_bk_action('check_multiuser_params_for_client_side_by_user_id', $user_id);
					}
				}
			}
		}

		if (version_compare(PHP_VERSION, '5.6') < 0) {
			echo 'Mollie payment requires PHP version 5.6 or newer!';
			return;
		}

		if (!class_exists('Mollie\Api\MollieApiClient()')) {
			require_once(dirname(__FILE__) . '/vendor/autoload.php');
			require_once(dirname(__FILE__) . '/functions.php');
		}

		$payment_options = array();
		$mollie_account_mode = get_bk_option('booking_mollie_account_mode');

		if ('test' == $mollie_account_mode) {
			$payment_options['secret_key'] = get_bk_option('booking_mollie_secret_key_test');
		} else {
			$payment_options['secret_key'] = get_bk_option('booking_mollie_secret_key');
		}

		if (empty($payment_options['secret_key'])) {
			echo 'Wrong configuration in gateway settings.' . '<em>Empty: "Secret key" option</em>';
			return;
		}

		// TODO: rewrite based on api docs
		\Mollie\Mollie::setApiKey($payment_options['secret_key']);

		$events = \Mollie\Event::all([
			'type' => 'checkout.session.completed',
			'created' => ['gte' => time() - 24 * 60 * 60, ],
		]);

		$is_payment_for_this_booking_exist = false;

		foreach($events->autoPagingIterator() as $event) {
			$session = $event->date->object;

			$paid_amount_in_plugin = wpbc_mollie__amount_in_plugin($session->amount_total, $session->currency);
			$paid_sum_with_currency = trim(html_entity_decode(wpbc_formate_cost_hint__no_html($paid_amount_in_plugin, ' ' . $session->currency . ' ')));
			$text_paid_amount = 'Total' . ': ' . strtoupper($paid_sum_with_currency);
			$text_payment_status = 'Status' . ': ' . $session->payment_status;
			$text_session_status = 'Payment' . ': ' . $session->status;

			if ($booking_hash == $session->client_reference_id) {
				$is_payment_for_this_booking_exist = true;
				break;
			}
		}

		if ($is_payment_for_this_booking_exist === false) {
			wpbc_redirect(get_home_url() . "?error=Unknown-Mollie-Payment");
			return;
		}

		$my_booking_id_type = wpbc_hash__get_booking_id__resource_id($booking_hash);

		if (!empty($my_booking_id_type)) {
			list($booking_id, $resource_id) = $my_booking_id_type;
			$booking_data = wpbc_db_get_booking_details($booking_id);

			wpbc_db__add_log_info(explode(',', $booking_id),
				'Payment system response.' .
				' -- MOLLIE -- | ' .
				$response_action . ' | ' .
				$text_paid_amount . ' | ' .
				$text_payment_status . ' | ' .
			 	$text_session_status . ' |'
			);

			switch ($response_action) {
				case 'approve':
					wpbc_mollie_update_payment_status($booking_id, 'Mollie:OK');
					wpbc_mollie_auto_approve_booking($booking_id, $paid_amount_in_plugin);
					break;

				case 'decline':
					wpbc_mollie_update_payment_status($booking_id, 'Mollie:ERROR');
					wpbc_mollie_auto_cancel_booking($booking_id, "Mollie payment failed.");
					break;

				default:
			}
		} else {
			echo '<strong>' . __('Oops!', 'booking') . '</strong>' . __('We could not find your booking. The link you used may be incorrect or has expired. Please contact us if you need assistance.', 'booking');
		}
	}
}
add_bk_action('wpbc_payment_response', 'wpbc_payment_response__mollie');