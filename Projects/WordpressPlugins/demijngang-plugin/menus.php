<?php
	add_action('admin_menu', 'demijngang_menu');
	
	function demijngang_menu() {
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