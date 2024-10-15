<?php
namespace EM\Payments\Mollie;

use EM_Booking, EM_Event, EM_Multiple_Bookings, EM_Pro, EM;

class Gateway extends EM\Payments\Gateway {
    public static $legacy = false;
    public static $gateway = 'mollie';
    public static $title = 'Mollie Payments';
    public static $status = 4;
    public static $status_txt = 'Awaiting Mollie Payment';
    public static $count_pending_spaces = true;
    public static $button_enabled = true;
    public static $rest_api = false;
    public static $payment_return = true;
    public static $payment_flow = array('redirect' => true, 'redirect-success' => true, 'redirect-cancel' => true);
    public static $has_timeout = true;
    public static $supports_multiple_bookings = true;
    public static $transaction_detail = array('link', 'sandbox link', 'mollie.com');
}