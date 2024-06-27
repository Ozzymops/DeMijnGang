<?php
/*
 * Plugin Name: Events Manager Pro Extensions
 * Description: Small extensions for Events Manager Pro to suit my needs.
 */

/*
 * USAGE: [events_list only_first_recurring=1]
 */

add_filter('em_events_get_default_search', 'custom_em_events_get_default_search_only_first_recurring', 1, 2);
function custom_em_events_get_default_search_only_first_recurring($args, $array) {
    $args['only_first_recurring'] = false;
    if (!empty($array['only_first_recurring']) && is_bool($array['only_first_recurring'])) {
        $args['only_first_recurring'] = $array['only_first_recurring'];
    }
}




add_filter('em_events_build_sql_conditions', 'custom_em_events_build_sql_conditions_only_first_recurring', 1, 2);
function custom_em_events_build_sql_conditions_only_first_recurring($conditions, $args) {
    global $wpdb;
    if (!empty($args['only_first_recurring']) && is_bool($args['only_first_recurring'])) {
        $sql = $wpdb->prepare("SELECT object_id FROM ".EM_META_TABLE." WHERE meta_value=%s AND meta_key='event-style'", $args['style']);
    }
}






function custom_em_events_get_default_search_only_first_recurring($searches, $array) {
    if (!empty($array['only_first_recurring'])) {
        $searches['only_first_recurring'] = $array['only_first_recurring'];
    }
}

function custom_em_events_get_only_first_recurring($events, $args) {
    if (!empty($args['only_first_recurring']) && is_numeric($args['only_first_recurring'])) {
        $recurring = [];

        foreach ($events as $event_key => $EM_Event) {
            $recurrence = $EM_Event -> recurrence_id;
            if (!empty($recurrence)) {
                if (in_array($recurrence, $recurring)) {
                    unset($events[$event_key]);
                }
                else {
                    array_push($recurring, $recurrence);
                }
            }
        }
    }
}
add_filter('em_events_get', 'custom_em_events_get_only_first_recurring');
?>