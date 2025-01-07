<?php
/**
 * @package Mollie Integration
 * @category Payment Gateway for Booking Calendar 
 * @author Justin Muris
 * @version 1.0
 * @modified 2024-12-17
 *
 * Integration based on iDEAL via Buckaroo implementation
 * Based on guide: https://wpbookingcalendar.com/faq/
 *
 */

if (!defined('ABSPATH')) exit;
if (!defined('WPBC_MOLLIE_GATEWAY_ID')) define('WPBC_MOLLIE_GATEWAY_ID', 'mollie');

function wpbc_mollie_transaction_request() {
	$mollie_obj = wpbc_mollie_get_object();
	$mollie = $mollie_obj['mollie'];
	$mollie_options = $mollie_obj['mollie_options'];

	try {
		$orderId = time();
		$protocol = isset($_SERVER['HTTPS']) && strcasecmp('off', $_SERVER['HTTPS']) !== 0 ? "https" : "http";
		$hostname = $_SERVER['HTTP_HOST'];
		$path = dirname($_SERVER['REQUEST_URI'] ?? $_SERVER['PHP_SELF']);

		$payment = $mollie->payments->create([
			"amount" => [
				"currency" => "EUR",
				"value" => "25.00",
			],
			"method" => \Mollie\Api\Types\PaymentMethod::IDEAL,
			"description" => "Order #{$orderId}",
			"redirectUrl" => "{$protocol}://{$hostname}{$path}/return.php?order_id={$orderId}",
			"webhookUrl" => "{$protocol}://{$hostname}{$path}/webhook.php",
			"metadata" => [
				"order_id" => $orderId,
			],
			"issuer" => ! empty($_POST["issuer"]) ? $_POST["issuer"] : null,
		]);

		database_write($orderId, $payment->status);
		header("Location: " . $payment->getCheckoutUrl(), true, 303);
	}
	catch (\Mollie\Api\Exceptions\ApiException $e) {
		echo "API call failed: " . htmlspecialchars($e->getMessage());
	}
}

function wpbc_mollie_get_object() {
	// create and return Mollie api object
	require_once(dirname(__FILE__) . "/Mollie/vendor/autoload.php");
	require_once(dirname(__FILE__) . "/Mollie/functions.php");

	// general options
	$mollie_options = array();
	$mollie_options['is_active'] = get_bk_option('booking_mollie_is_active');
	$mollie_options['return_url'] = get_bk_option('booking_mollie_return_url');
	$mollie_options['cancel_return_url'] = get_bk_option('booking_mollie_cancel_return_url');
	$mollie_options['payment_button_title'] = get_bk_option('booking_mollie_payment_button_title');
	$mollie_options['payment_button_title'] = wpbc_lang($mollie_options['payment_button_title']);
	$mollie_options['is_test_mode'] = (get_bk_option('booking_mollie_test') == 'TEST' ? true : false);
	$mollie_options['is_auto_approve_cancell_booking'] = get_bk_option('booking_mollie_is_auto_approve_cancell_booking');
	// $mollie_options['subject'] = get_bk_option('booking_mollie_subject');

	// unique options
	$mollie_options['profileId'] = get_bk_option('booking_mollie_profileId');
	$mollie_options['key'] = get_bk_option('booking_mollie_key');
	$mollie_options['test_key'] = get_bk_option('booking_mollie_test_key');

	// create object
	$mollie = new \Mollie\Api\MollieApiClient();
	// check test mode etc.
	$mollie->setApiKey($mollie_options['test_key']);

	return array('mollie' => $mollie, 'mollie_options' => $mollie_options);
}

// payment gateway api
class WPBC_Gateway_API_MOLLIE extends WPBC_Gateway_API {
	// create payment form
	public function get_payment_form($output, $params, $gateway_id = '') {
		// check if showing 'this' gateway
		if (((!empty($gateway_id)) && ($gateway_id !== $this->get_id())) || (!$this->is_gateway_on())) return $output;

		// mollie integration
		$mollie_obj = wpbc_mollie_get_object();
		$mollie = $mollie_obj['mollie'];
		$mollie_options = $mollie_obj['mollie_options'];

		// build payment form
		// ob_start();

		wpbc_mollie_transaction_request();

		// $payment_form = ob_get_clean();
		// return $output . $payment_form;
		return $output;
	}

	// settings
	public function init_settings_fields() {
		$this->fields = array();
		
		// toggle gateway
		$this->fields['is_active'] = array(
			'type' => 'checkbox',
			'default' => 'On',
			'title' => __('Enable / Disable', 'booking'),
			'label' => __('Enable this payment gateway', 'booking'),
			'description' => '',
			'group' => 'general'
		);

		// profile id
		$this->fields['profileId'] = array(
			'type' => 'text',
			'default' => '',
			'title' => __('Profile ID', 'booking'),
			'description' => __('Enter your Mollie profile ID', 'booking') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
			'description_tag' => 'span',
			'css' => '',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_grayed'
		);

		// key
		$this->fields['key'] = array(
			'type' => 'text',
			'default' => '',
			'title' => __('API Key', 'booking'),
			'description' => __('Enter your Mollie API key', 'booking') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
			'description_tag' => 'span',
			'css' => '',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_grayed'
		);

		// test key
		$this->fields['test_key'] = array(
			'type' => 'text',
			'default' => '',
			'title' => __('API Test Key', 'booking'),
			'description' => __('Enter your Mollie API test key', 'booking') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
			'description_tag' => 'span',
			'css' => '',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_grayed'
		);

		// test mode
		$this->fields['test'] = array(
			'type' => 'select',
			'default' => 'TEST',
			'title' => __('Toggle test mode', 'booking'),
			'description' => __('Select TEST for test mode, LIVE for live mode', 'booking'),
			'description_tag' => 'span',
			'css' => '',
			'options' => array(
				'TEST' => __('TEST', 'booking'),
				'LIVE' => __('LIVE', 'booking'),
			),
			'group' => 'general'
		);

		// payment button title
		$this->fields['payment_button_title'] = array(
			'type' => 'text',
			'default' => __('Pay via', 'booking') . ' Mollie',
			'placeholder' => __('Pay via', 'booking') . ' Mollie',
			'title' => __('Payment button title', 'booking'),
			'description' => __('Enter the title of the payment button', 'booking'),
			'description_tag' => 'p',
			'css' => 'width: 100%',
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_payment_button_title wpbc_sub_settings_grayed'
		);

		// subject
		$this->fields['subject'] = array(
			'type' => 'textarea',
			'default' => sprintf(__('Payment for booking %s on these day(s): %s', 'booking'), '[resource_title]', '[dates]'),
			'placeholder' => sprintf(__('Payment for booking %s on these day(s): %s', 'booking'), '[resource_title]', '[dates]'),
			'title' => __('Payment description at gateway website', 'booking'),
			'description' => __('Enter the service name or reason for payment here', 'booking'),
			'description_tag' => 'p',
			'css' => 'width: 100%',
			'rows' => 2,
			'group' => 'general',
			'tr_class' => 'wpbc_sub_settings_is_description_show wpbc_sub_settings_grayedNO'
		);

		// success url
		$this->fields['return_url_prefix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<tr valign="top" class="wpbc_tr_mollie_return_url"><th scope="row">' . WPBC_Settings_API::label_static('mollie_return_url', array('title' => __('Return URL after success', 'booking'), 'label_css' => '')) . '</th><td><fieldset><code style="font=size: 14px;">' . get_option('siteurl') . '</code>'
		);

		$this->fields['return_url'] = array(
			'type' => 'text',
			'default' => '/successful',
			'placeholder' => '/successful',
			'css' => 'width: 75%',
			'group' => 'auto_approve_cancel',
			'only_field' => true			
		);

		$this->fields['return_url_sufix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<p class="description" style="line-height: 1.7em; margin: 0;">' . __('Return URL after completion', 'booking') . '</p></fieldset></td></tr>'
		);

		// failed url
		$this->fields['cancel_return_url_prefix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<tr valign="top" class="wpbc_tr_mollie_cancel_return_url"><th scope="row">' . WPBC_Settings_API::label_static('mollie_return_url', array('title' => __('Return URL after fail', 'booking'), 'label_css' => '')) . '</th><td><fieldset><code style="font=size: 14px;">' . get_option('siteurl') . '</code>'
		);

		$this->fields['cancel_return_url'] = array(
			'type' => 'text',
			'default' => '/failed',
			'placeholder' => '/failed',
			'css' => 'width: 75%',
			'group' => 'auto_approve_cancel',
			'only_field' => true			
		);

		$this->fields['cancel_return_url_sufix'] = array(
			'type' => 'pure_html',
			'group' => 'auto_approve_cancel',
			'html' => '<p class="description" style="line-height: 1.7em; margin: 0;">' . __('Return URL after completion', 'booking') . '</p></fieldset></td></tr>'
		);

		// auto approve/cancel
		$this->fields['is_auto_approve_cancell_booking'] = array(
			'type' => 'checkbox',
			'default' => 'Off',
			'title' => __('Automatically approve/cancel booking', 'booking'),
			'label' => __('Check this box to automatically approve bookings on success, or cancel on fail.', 'booking'),
			'description' => '',
			'description_tag' => 'p',
			'group' => 'auto_approve_cancel'
		);
	}

	// gateway info
	public function get_gateway_info() {
		$gateway_info = array(
			'id' => $this->get_id(),
			'title' => 'Mollie',
			'currency' => get_bk_option('booking_' . $this->get_id() . '_curency'),
			'enabled' => $this->is_gateway_on()
		);

		return $gateway_info;
	}

	// get payment status types
	public function get_payment_status_array() {
		// not sure if right way around
		return array(
			'open' => array('Mollie:Open'),
			'pending' => array('Mollie:Pending'),
			'authorized' => array('Mollie:Authorized'),
			'paid' => array('Mollie:Paid'),
			'canceled' => array('Mollie:Canceled'),
			'expired' => array('Mollie:Expired'),
			'failed' => array('Mollie:Failed')
		);
	}

	// update payment status
	public function update_payment_status__after_response($response_status, $pay_system, $status, $booking_id, $wp_nonce) {
		if ($pay_system == WPBC_MOLLIE_GATEWAY_ID) {
			// mollie integration
			$mollie_obj = wpbc_mollie_get_object();
			$mollie = $mollie_obj['mollie'];
			$mollie_options = $mollie_obj['mollie_options'];

			if (isset($_REQUEST['trxid'])) {
				$status = '';

				if (isset($_REQUEST['notify']) || isset($_REQUEST['callback'])) {
					$payment = $mollie->payments->get($_REQUEST['trxid']);

					switch($payment->status) {
						case "open":
							$status = 'Mollie:Open';
							break;
						
						case "pending":
							$status = 'Mollie:Pending';
							break;

						case "authorized":
							$status = 'Mollie:Authorized';
							break;

						case "paid":
							$status = 'Mollie:Paid';
							break;
						
						case "canceled":
							$status = 'Mollie:Canceled';
							break;

						case "expired":
							$status = 'Mollie:Expired';
							break;

						case "failed":
							$status = 'Mollie:Failed';
							break;
					}
				}
				else {
					switch($_REQUEST['status']) {
						case "open":
							$status = 'Mollie:Open';
							break;
						
						case "pending":
							$status = 'Mollie:Pending';
							break;

						case "authorized":
							$status = 'Mollie:Authorized';
							break;

						case "paid":
							$status = 'Mollie:Paid';
							break;
						
						case "canceled":
							$status = 'Mollie:Canceled';
							break;

						case "expired":
							$status = 'Mollie:Expired';
							break;

						case "failed":
							$status = 'Mollie:Failed';
							break;
					}
				}

				return $status;
			}
		}

		return $response_status;
	}

	// approval / cancellation automation
	public function auto_approve_or_cancell_and_redirect($pay_system, $status, $booking_id) {
		if ($pay_system == WPBC_MOLLIE_GATEWAY_ID) {
			$auto_approve = get_bk_option('booking_mollie_is_auto_approve_cancell_booking');
			$payment_status = $this->get_payment_status_array();

			if (in_array($status, $payment_status['paid'])) {
				if ($auto_approve == 'On') { wpbc_auto_approve_booking__after_payment($booking_id); }
				wpbc_redirect(get_bk_option('booking_mollie_return_url'));
			}

			if (in_array($status, $payment_status['canceled']) || in_array($status, $payment_status['expired']) || in_array($status, $payment_status['failed'])) {
				if ($auto_approve == 'On') { wpbc_auto_cancel_booking__after_payment($booking_id); }
				wpbc_redirect(get_bk_option('booking_mollie_cancel_return_url'));
			}
		}
	}
}

// settings page
class WPBC_Settings_Page_Gateway_MOLLIE extends WPBC_Page_Structure {
	public $gateway_api = false;

	// define interface
	public function get_api($init_fields_values = array()) {
		if ($this->gateway_api === false) {
			$this->gateway_api = new WPBC_Gateway_API_MOLLIE(WPBC_MOLLIE_GATEWAY_ID, $init_fields_values);
		}

		return $this->gateway_api;
	}

	// admin check
	public function in_page() {
		if (get_bk_option('booking_super_admin_receive_regular_user_payments') == 'On' && !wpbc_is_mu_user_can_be_here('only_super_admin')) {
			return (string) rand(100000, 1000000);
		}

		return 'wpbc-settings';
	}

	// build tabs
	public function tabs() {
		$tabs = array();
		$subtabs = array();

		$subtabs[WPBC_MOLLIE_GATEWAY_ID] = array(
			'type' => 'subtab',
			'title' => 'Mollie',
			'page_title' => sprintf(__('%s Settings', 'booking'), 'Mollie' ),
			'hint' => sprintf(__('Integration of %s payment system' ,'booking' ), 'Mollie' ),
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

	// content
	public function content() {
		$this->css();

		do_action('wpbc_hook_settings_page_header', 'gateway_settings');
		do_action('wpbc_hook_settings_page_header', 'gateway_settings_' . WPBC_MOLLIE_GATEWAY_ID);

		if (!wpbc_is_mu_user_can_be_here('activated_user')) return false;

		$submit_form_name = 'wpbc_gateway_' . WPBC_MOLLIE_GATEWAY_ID;

		// build page
		echo '<span class="wpdevelop">';
		wpbc_js_for_bookings_page();
		echo '</span>';

		?>
			<div class="clear"></div>
			<span class="metabox-holder">
				<form name="<?php echo $submit_form_name; ?>" id="<?php echo $submit_form_name; ?>" action="" method="post" autocomplete="off">
					<?php
					wp_nonce_field('wpbc_settings_page_' . $submit_form_name);
					?>
					<input type="hidden" name="is_form_sbmitted_<?php echo $submit_form_name; ?>" id="is_form_sbmitted_<?php echo $submit_form_name; ?>" value="1" />
					<div class="wpbc-settings-notice-warning notice-helpful-info">
						<div>
							<strong><?php _e('Note!', 'booking'); ?></strong><strong style="padding-left: 10px;">1. </strong>
							<?php
								printf(__('Processing your payments through Mollie', 'booking'));
							?>
						</div>
					</div>
					<div class="clear"></div>
					<div class="metabox-holder">
						<div class="wpbc_settings_row wpbc_settings_row_left_NO">
						<?php
							wpbc_open_meta_box_section($submit_form_name . 'general', __('Mollie Settings', 'booking'));
							$this->get_api()->show('general');
							wpbc_close_meta_box_section();
						?>
						<div class="clear"></div>
						<div class="wpbc_settings_row wpbc_settings_row_left_NO">
						<?php
							wpbc_open_meta_box_section($submit_form_name . 'auto_approve_cancel', __('Advanced', 'booking'));
							$this->get_api()->show('auto_approve_cancel');
							wpbc_close_meta_box_section();
						?>
						</div>
						<div class="clear"></div>
					</div>
					<input type="submit" value="<?php _e('Save Changes', 'booking'); ?>" class="button button-primary" />
				</form>
			</span>
		<?php

		$this->enqueue_js();
	}

	// check if data is updated
	public function maybe_update() {
		$init_fields_values = array();
		$this->get_api($init_fields_values);

		$submit_form_name = 'wpbc_gateway_' . WPBC_MOLLIE_GATEWAY_ID;
		$this->get_api()->validated_form_id = $submit_form_name;

		if (isset($_POST['is_form_sbmitted_' . $submit_form_name])) {
			$nonce_gen_time = check_admin_referer('wpbc_settings_page_' . $submit_form_name);
			$this->update();
		}
	}

	// actually update
	public function update() {
		$validated_fields = $this->get_api()->validate_post();
		$validated_fields = apply_filters('wpbc_gateway_mollie_validate_fields_before_saving', $validated_fields);
		$this->get_api()->save_to_db($validated_fields);
		wpbc_show_message(__('Settings saved.', 'booking'), 5);
	}

	// css for this page
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

	// javascript for this page
	private function enqueue_js() {

	}
}
add_action('wpbc_menu_created', array(new WPBC_Settings_Page_Gateway_MOLLIE(), '__construct'));

// validate fields
function wpbc_gateway_mollie_validate_fields_before_saving__all($validated_fields) {
	$validated_fields['return_url'] = wpbc_make_link_relative($validated_fields['return_url']);
	$validated_fields['cancel_return_url'] = wpbc_make_link_relative($validated_fields['cancel_return_url']);

	if (wpbc_is_this_demo()) {
		$validated_fields['profileId'] = '';
		$validated_fields['key'] = '';
		$validated_fields['test_key'] = '';
		$validated_fields['test'] = 'TEST';
	}

	return $validated_fields;
}
add_filter('wpbc_gateway_mollie_validate_fields_before_saving', 'wpbc_gateway_mollie_validate_fields_before_saving__all', 10, 1);

function wpbc_booking_activate_MOLLIE() {
	$op_prefix = 'booking_' . WPBC_MOLLIE_GATEWAY_ID . '_';

	add_bk_option($op_prefix . 'is_active', 'Off');
	add_bk_option($op_prefix . 'subject', sprintf(__('Payment for booking %s on these day(s): %s', 'booking'), '[resource_title]', '[dates]'));
	add_bk_option($op_prefix . 'return_url', '/successful');
	add_bk_option($op_prefix . 'cancel_return_url', '/failed');
	add_bk_option($op_prefix . 'payment_button_title', __('Pay via', 'booking') . ' Mollie');
	add_bk_option($op_prefix . 'profileId', '');
	add_bk_option($op_prefix . 'key', '');
	add_bk_option($op_prefix . 'test_key', '');
	add_bk_option($op_prefix . 'test', 'TEST');
	add_bk_option($op_prefix . 'is_auto_approve_cancell_booking', 'Off');
}
add_bk_action('wpbc_other_versions_activation', 'wpbc_booking_activate_MOLLIE');

function wpbc_booking_deactivate_MOLLIE() {
	$op_prefix = 'booking_' . WPBC_MOLLIE_GATEWAY_ID . '_';
	
	delete_bk_option($op_prefix . 'is_active');
	delete_bk_option($op_prefix . 'subject');
	delete_bk_option($op_prefix . 'return_url');
	delete_bk_option($op_prefix . 'cancel_return_url');
	delete_bk_option($op_prefix . 'payment_button_title');
	delete_bk_option($op_prefix . 'profileId');
	delete_bk_option($op_prefix . 'key');
	delete_bk_option($op_prefix . 'test_key');
	delete_bk_option($op_prefix . 'test');
	delete_bk_option($op_prefix . 'is_description_show');
	delete_bk_option($op_prefix . 'is_auto_approve_cancell_booking');
}
add_bk_action('wpbc_other_versions_deactivation', 'wpbc_booking_deactivate_MOLLIE');

// ajax
function wpbc_ajax_WPBC_PAY_VIA_MOLLIE() {
	$nonce = (isset($_REQUEST['wpbc_nonce'])) ? $_REQUEST['wpbc_nonce'] : '';

	if ($nonce === '') return false;

	if (wpbc_is_use_nonce_at_front_end()) {
		if (!wp_verify_nonce($nonce, $_POST['action'])) {
			wp_die(
				sprintf(__('%sError!%s Request does not pass security checks. Please refresh the page and try again.', 'booking'), '<strong>', '</strong>') . '<br/>' .
				sprintf(__('Please check %shere%s for more information.', 'booking'), '<a href="https://wpbookingcalendar.com/faq/request-do-not-pass-security-check/?after_update=10.1.1" target="_blank">', '</a>')
			);
		}
	}

	wpbc_mollie_transaction_request();
	wp_die('');
}
add_action('wp_ajax_nopriv_' . 'WPBC_PAY_VIA_MOLLIE', 'wpbc_ajax_' . 'WPBC_PAY_VIA_MOLLIE');
add_action('wp_ajax_' . 'WPBC_PAY_VIA_MOLLIE', 'wpbc_ajax_' . 'WPBC_PAY_VIA_MOLLIE');