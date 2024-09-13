<?php
namespace EM\Toolbox;
	
class Past_Events {
	
	public static function init() {
		
		if( get_option('dbem_past_events') !== 'published' ) {
			if( !wp_next_scheduled('emp_cron_process_past_events') ){
				wp_schedule_event( time(), 'em_minute', 'emp_cron_process_past_events');
			}
			add_action('emp_cron_process_past_events', array( static::class, 'process' ) );
			
			// register post status
			if( get_option('dbem_past_events') === 'past' ) {
				add_action( 'init', array( static::class, 'post_status' ) );
				add_filter( 'wp_count_posts', array( static::class, 'wp_count_posts' ), 10, 3 );
			}
			add_filter( 'em_event_get_status', array( static::class, 'event_get_status' ), 10, 2 );
		}
	}
	
	public static function process(){
		// get all past published events, 100 at a time
		$args = array( 'scope' => 'past', 'status' => 1, 'limit' => 100 );
		$EM_Events = \EM_Events::get( $args );
		add_filter('em_event_can_manage', '__return_true');
		do {
			foreach ( $EM_Events as $EM_Event ) {
				// double-check event is really past
				$is_past = get_option( 'dbem_events_current_are_past' ) ? $EM_Event->end()->getTimestamp() < time() : $EM_Event->start()->getTimestamp() < time();
				if ( !$is_past ) {
					break;
				}
				// trash or change status
				$status_action = get_option( 'dbem_past_events' );
				if ( $status_action === 'past' ) {
					// change status
					$EM_Event->force_status = $EM_Event->post_status = 'past';
					$EM_Event->save();
				} elseif ( $status_action === 'trash' ) {
					// trash
					wp_trash_post( $EM_Event->post_id );
				} elseif ( $status_action === 'delete' ) {
					$EM_Event->delete( true );
				}
				break;
			}
			$EM_Events = \EM_Events::get( $args );
		} while ( count( $EM_Events ) > 0 );
		remove_filter('em_event_can_manage', '__return_true');
	}
	
	public static function event_get_status( $status, $EM_Event ){
		if( $EM_Event->post_status === 'past' ) {
			$EM_Event->event_status = 0; // like a draft
		}
		return $status;
	}
	
	public static function post_status(){
		register_post_status( 'past', array(
			'label'                     => emp__( 'Past' ),
			'public'                    => is_admin(),
			'publicly_queryable' 	    => false,
			'protected'                 => true,
			'exclude_from_search'       => false,
			'show_in_admin_all_list'    => true,
			'show_in_admin_status_list' => true,
			'label_count'               => _n_noop( 'Past <span class="count">(%s)</span>', 'Past <span class="count">(%s)</span>'),
		) );
		register_post_status( 'future', array(
			'label'                     => emp__( 'Future' ),
			'public'                    => is_admin(),
			'publicly_queryable' 	    => false,
			'protected'                 => true,
			'exclude_from_search'       => false,
			'show_in_admin_all_list'    => true,
			'show_in_admin_status_list' => true,
			'label_count'               => _n_noop( 'Future <span class="count">(%s)</span>', 'Future <span class="count">(%s)</span>'),
		) );
	}
	
	public static function wp_count_posts( $counts, $type, $perm ) {
		$cache_key = _count_posts_cache_key( $type, $perm );
		// recount future events if we haven't cached a count already
		$counts = wp_cache_get( $cache_key, 'counts' );
		if ( false !== $counts && empty( $counts->future ) ) {
			$counts->future = \EM_Events::count( array('scope' => 'future', 'status' => false) );
		}
		wp_cache_set( $cache_key, $counts, 'counts' );
		return $counts;
	}
	
}
Past_Events::init();