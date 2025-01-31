<?php
	function demijngang_main_menu() {
		add_menu_page(
			'De MijnGang',
			'De MijnGang',
			'manage_options',
			'demijngang',
			'',
			'dashicons-admin-generic',
			1000
		);
	}
	add_action('admin_menu', 'demijngang_main_menu');