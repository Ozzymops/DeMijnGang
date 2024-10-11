<?php
	// Main
	function demijngang_restaurant_menu() {
		add_submenu_page(
			'demijngang',
			'Restaurant',
			'Restaurant',
			'manage_options',
			'demijngang',
			'demijngang_restaurant_page'
		);
	}
	add_action('admin_menu', 'demijngang_restaurant_menu');

	function demijngang_restaurant_page() {
		?>
			<div class="wrap">
				<h1>Restaurant Menu</h1>
				<form method="post" action="options.php" enctype="multipart/form-data">
					<?php
						settings_fields('demijngang_options_group');
						do_settings_sections('demijngang');
						submit_button();
					?>
				</form>
			</div>
		<?php
	}
	
	// Settings
	function demijngang_restaurant_settings() {
		// TODO: Group into arrays?
		register_setting('demijngang_options_group', 'restaurant_lunch_1_title', 'sanitize_text_field');
		register_setting('demijngang_options_group', 'restaurant_lunch_1_description', 'sanitize_textarea_field');
		register_setting('demijngang_options_group', 'restaurant_lunch_1_image', function($image) { return sanitize_image($image, 'restaurant_lunch_1_image'); });

		register_setting('demijngang_options_group', 'restaurant_lunch_2_title', 'sanitize_text_field');
		register_setting('demijngang_options_group', 'restaurant_lunch_2_description', 'sanitize_textarea_field');
		register_setting('demijngang_options_group', 'restaurant_lunch_2_image', function($image) { return sanitize_image($image, 'restaurant_lunch_2_image'); });

		register_setting('demijngang_options_group', 'restaurant_dinner_title', 'sanitize_text_field');
		register_setting('demijngang_options_group', 'restaurant_dinner_description', 'sanitize_textarea_field');
		register_setting('demijngang_options_group', 'restaurant_dinner_image', function($image) { return sanitize_image($image, 'restaurant_dinner_image'); });

		add_settings_section('restaurant_lunch_1_section', 'Lunch: gerecht 1', null, 'demijngang');
		add_settings_section('restaurant_lunch_2_section', 'Lunch: gerecht 2', null, 'demijngang');
		add_settings_section('restaurant_dinner_section', 'Avondeten', null, 'demijngang');

		add_settings_field('restaurant_lunch_1_title', 'Gerecht', function() { return demijngang_restaurant_callback('restaurant_lunch_1_title', 0); }, 'demijngang', 'restaurant_lunch_1_section');
		add_settings_field('restaurant_lunch_1_description', 'Beschrijving', function() { return demijngang_restaurant_callback('restaurant_lunch_1_description', 1); }, 'demijngang', 'restaurant_lunch_1_section');
		add_settings_field('restaurant_lunch_1_image', 'Foto', function() { return demijngang_restaurant_callback('restaurant_lunch_1_image', 2); }, 'demijngang', 'restaurant_lunch_1_section');

		add_settings_field('restaurant_lunch_2_title', 'Gerecht', function() { return demijngang_restaurant_callback('restaurant_lunch_2_title', 0); }, 'demijngang', 'restaurant_lunch_2_section');
		add_settings_field('restaurant_lunch_2_description', 'Beschrijving', function() { return demijngang_restaurant_callback('restaurant_lunch_2_description', 1); }, 'demijngang', 'restaurant_lunch_2_section');
		add_settings_field('restaurant_lunch_2_image', 'Foto', function() { return demijngang_restaurant_callback('restaurant_lunch_2_image', 2); }, 'demijngang', 'restaurant_lunch_2_section');

		add_settings_field('restaurant_dinner_title', 'Gerecht', function() { return demijngang_restaurant_callback('restaurant_dinner_title', 0); }, 'demijngang', 'restaurant_dinner_section');
		add_settings_field('restaurant_dinner_description', 'Beschrijving', function() { return demijngang_restaurant_callback('restaurant_dinner_description', 1); }, 'demijngang', 'restaurant_dinner_section');
		add_settings_field('restaurant_dinner_image', 'Foto', function() { return demijngang_restaurant_callback('restaurant_dinner_image', 2); }, 'demijngang', 'restaurant_dinner_section');
	}
	add_action('admin_init', 'demijngang_restaurant_settings');

	function demijngang_restaurant_callback($title, $type) {
		$content = get_option($title);

		if ($type == 0) { // Text input
			echo "<input type='text' name='" . $title . "' value='" . esc_attr($content) . "' />";
		}
		else if ($type == 1) { // Text field input
			echo "<textarea name='" . $title . "'>" . esc_textarea($content) . "</textarea>";
		}
		else { // Image input
			echo "<h4>Vanwege limitaties, selecteer altijd een foto voordat je veranderingen opslaat! De foto wordt anders vervangen door een standaard placeholder.</h4>";
			echo "<input type='file' name='" . $title . "' accept='image/*' />";
			if ($content) {
				echo "<br/><img src='" . esc_url($content) . "' style='max-width:150px; margin-top:10px;' />";
			}
		}
	}

	// Shortcodes
	function demijngang_restaurant_shortcodes() {
		add_shortcode('lunch_1_title', function() { return get_option('restaurant_lunch_1_title'); });
		add_shortcode('lunch_1_description', function() { return get_option('restaurant_lunch_1_description'); });
		add_shortcode('lunch_1_image', function() { return get_option('restaurant_lunch_1_image'); });

		add_shortcode('lunch_2_title', function() { return get_option('restaurant_lunch_2_title'); });
		add_shortcode('lunch_2_description', function() { return get_option('restaurant_lunch_2_description'); });
		add_shortcode('lunch_2_image', function() { return get_option('restaurant_lunch_2_image'); });

		add_shortcode('dinner_title', function() { return get_option('restaurant_dinner_title'); });
		add_shortcode('dinner_description', function() { return get_option('restaurant_dinner_description'); });
		add_shortcode('dinner_image', function() { return get_option('restaurant_dinner_image'); });
	}
	add_action('init', 'demijngang_restaurant_shortcodes');

	// TODO: reset data every week?
	// TODO: auto update date on page?

	// Cleanup, thanks to ChatGPT
	function sanitize_image($image, $option_name) {
		// Check if there is an uploaded file
		if (!empty($_FILES) && isset($_FILES[$option_name]) && $_FILES[$option_name]['size'] > 0) {
			// Attempt to handle the file upload
			$image_id = media_handle_upload($option_name, 0);
			if (is_wp_error($image_id)) {
				// If there was an error uploading the image, display an error message
				add_settings_error($option_name, $option_name . '_error', 'Error uploading image.');
				// Return the existing image URL or fallback to the placeholder image
				return !empty($image) ? $image : plugin_dir_url(__FILE__) . 'images/placeholder.jpg';
			} else {
				// Return the URL of the uploaded image
				return wp_get_attachment_url($image_id);
			}
		}
	
		// If no file is uploaded or the $_FILES array is empty, use the existing image or fallback to the placeholder
		return !empty($image) ? $image : plugin_dir_url(__FILE__) . 'images/placeholder.jpg';
	}
	
	// Scripts
	function demijngang_enqueue_scripts($hook) {
		if ($hook !== 'demijngang_menu' && $hook !== 'demijngang_restaurantmenu_page') {
			return;
		}

		// Enqueue media uploader scripts
		wp_enqueue_media();

		// Enqueue custom script to handle media uploader (if needed)
		// You can add a JS file to handle image selection via media library
		// wp_enqueue_script('de-mijngang-media', plugin_dir_url(__FILE__) . 'js/media.js', array('jquery'), '1.0', true);
	}
	add_action('admin_enqueue_scripts', 'demijngang_enqueue_scripts');