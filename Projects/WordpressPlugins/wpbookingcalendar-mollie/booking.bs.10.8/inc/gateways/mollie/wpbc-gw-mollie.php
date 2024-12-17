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

function wpbc_mollie_get_object() {
	// create and return Mollie api object
	require_once(dirname(__FILE__) . "/Mollie/vendor/autoload.php");
	require_once(dirname(__FILE__) . "/Mollie/functions.php");

	// db shit to get keys
	$mollie_test_key = "test_BSg7zzRM3vffPrUrnBC99qGUSMrwjV";

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
		if ((!empty($gateway_id) && $gateway_id !== $this->get_id()) || !$this->is_gateway_on()) { return $output; }

		// mollie integration
		$mollie_obj = wpbc_mollie_get_object();
		$mollie = $mollie_obj['mollie'];
		$mollie_options = $mollie_obj['mollie_options'];

		// get payment methods
		// actually integrate in future? -> $methods = $mollie->methods->allAvailable();
		$payment_method = array(
			'ideal' => 'iDEAL',
			'creditcard' => 'Credit Card'
		);

		// build payment form
		$html_client_id = 'mollie_' . $params['booking_resource_id'];
		ob_start();
		
		?>
			<div id="<?php echo $html_client_id; ?>" class="mollie_div wpbc-payment-form" style="text-align: left; clear: both;">
			<form method="post" name="Mollie<?php echo $html_client_id; ?>"
		<?php
			echo wp_nonce_field('WPBC_PAY_VIA_MOLLIE', 'wpbc_nonce_' . $html_client_id, true, false);
			echo '<div class="wpbc_mollie_ajax_response" style="display: block;"></div>';
		?>
			<a href="javascript:void(0);" class="wpbc_button_light wpbc_button_gw wpbc_button_gw_mollie" onclick="javsacript:wpbc_pay_via_mollie(<?php echo $params['booking_resource_id']; ?>);"><?php echo $mollie_options['payment_button_title']; ?></a>
			<table class="wpbc_mollie_payment_table" cellspacing="0" cellpadding="0">
				<tr>
					<td><label><?php _e('Pay via', 'booking'); ?></label>:</td>
					<td>
						<select name="mollie_payment" style="height: 29px; padding: 0 6px;" size="1">
						<?php
							foreach ($payment_method as $payment_method_id => $payment_method_name) {
								?><option value="<?php echo $payment_method_id; ?>"><?php echo $payment_method_name; ?></option><?php
							}
						?>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="display: none;">
						<input type="hidden" name="mollie_nonce" value="<?php echo $params['__nonce']; ?>" />
						<input type="hidden" name="purchaseId" maxlength="16" value="<?php echo substr($params['booking_id'], 0, 16); ?>" />
						<!-- <input type="hidden" name="description" maxlength="32" value="<?php echo $mollie_options['subject']; ?>" /> -->
						<input type="hidden" name="amount" size="10" title="Cost" value="<?php echo $params['cost_in_gateway']; ?>" />
					</td>			
				</tr>	
			</table>
			</div>
		<?php

		$payment_form = ob_get_clean();
		return $output . $payment_form;
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
			'description' => __('Required', 'booking') . '.<br/>' . __('Enter your Mollie profile ID', 'booking') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
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
			'description' => __('Required', 'booking') . '.<br/>' . __('Enter your Mollie API key', 'booking') . ((wpbc_is_this_demo()) ? wpbc_get_warning_text_in_demo_mode() : ''),
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
			'currency' => '',
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
	public function get_api($init_fields_value = array()) {
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
			'page_title' => __('Mollie Settings', 'booking'),
			'hint' => __('Mollie integration', 'booking'),
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

		if (!wpbc_is_mu_user_can_be_here('activated_user')) { return false; }

		$submit_form_name = 'wpbc_gateway_' . WPBC_MOLLIE_GATEWAY_ID;

		// build page
		echo '<span class="wpdevelop">';
		wpbc_js_for_bookings_page();
		echo '</span>';

		?>
			<div class="clear"></div>
			<span class="metabox-holder">
				<form name="<?php echo $submit_formName; ?>" id="<?php echo $submit_form_name; ?>" action="" method="post" autocomplete="off">
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
		
	}
}