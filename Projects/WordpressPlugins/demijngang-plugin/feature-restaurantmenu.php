<?php
	add_action('admin_menu', 'demijngang_restaurantmenu_menu');
	
	function demijngang_restaurantmenu_menu() {
		add_submenu_page(
			'demijngang',
			'Restaurant Menu',
			'Restaurant Menu',
			'manage_options',
			'demijngang',
			'demijngang_restaurantmenu_page'
		);
	}

	function demijngang_restaurantmenu_page() {
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
	
	add_action('admin_init', 'demijngang_restaurantmenu_settings');
	
	function demijngang_restaurantmenu_settings() {
		register_setting('demijngang_options_group', 'meal_1_title', 'sanitize_text_field');
		register_setting('demijngang_options_group', 'meal_1_description', 'sanitize_textarea_field');
		register_setting('demijngang_options_group', 'meal_1_image', function($image) {
			return sanitize_image($image, 'meal_1_image');
		});
		
		register_setting('demijngang_options_group', 'meal_2_title', 'sanitize_text_field');
		register_setting('demijngang_options_group', 'meal_2_description', 'sanitize_textarea_field');
		register_setting('demijngang_options_group', 'meal_2_image', function($image) {
			return sanitize_image($image, 'meal_2_image');
		});
		
		add_settings_section(
			'meal_1_section',
			'Maaltijd 1',
			null,
			'demijngang'
		);
		
		add_settings_section(
			'meal_2_section',
			'Maaltijd 2',
			null,
			'demijngang'
		);
		
		add_settings_field(
			'meal_1_title',
			'Naam',
			'meal_1_title_callback',
			'demijngang',
			'meal_1_section'
		);
		
		add_settings_field(
			'meal_1_description',
			'Beschrijving',
			'meal_1_description_callback',
			'demijngang',
			'meal_1_section'
		);
		
		add_settings_field(
			'meal_1_image',
			'Afbeelding',
			'meal_1_image_callback',
			'demijngang',
			'meal_1_section'
		);
		
		add_settings_field(
			'meal_2_title',
			'Naam',
			'meal_2_title_callback',
			'demijngang',
			'meal_2_section'
		);
		
		add_settings_field(
			'meal_2_description',
			'Beschrijving',
			'meal_2_description_callback',
			'demijngang',
			'meal_2_section'
		);
		
		add_settings_field(
			'meal_2_image',
			'Afbeelding',
			'meal_2_image_callback',
			'demijngang',
			'meal_2_section'
		);
	}
	
	function meal_1_title_callback() {
		$meal_1_title = get_option('meal_1_title');
		echo "<input type='text' name='meal_1_title' value='" . esc_attr($meal_1_title) . "' />";
	}
	
	function meal_1_description_callback() {
		$meal_1_description = get_option('meal_1_description');
		echo "<textarea name='meal_1_description'>" . esc_textarea($meal_1_description) . "</textarea>";
	}
	
	function meal_1_image_callback() {
		$meal_1_image = get_option('meal_1_image');
		echo "<input type='file' name='meal_1_image' accept='image/*' />";
		if ($meal_1_image) {
			echo "<br/><img src='" . esc_url($meal_1_image) . "' style='max-width:150px; margin-top:10px;' />";
		}
	}
	
	function meal_2_title_callback() {
		$meal_2_title = get_option('meal_2_title');
		echo "<input type='text' name='meal_2_title' value='" . esc_attr($meal_2_title) . "' />";
	}
	
	function meal_2_description_callback() {
		$meal_2_description = get_option('meal_2_description');
		echo "<textarea name='meal_2_description'>" . esc_textarea($meal_2_description) . "</textarea>";
	}
	
	function meal_2_image_callback() {
		$meal_2_image = get_option('meal_2_image');
		echo "<input type='file' name='meal_2_image' accept='image/*' />";
		if ($meal_2_image) {
			echo "<br/><img src='" . esc_url($meal_2_image) . "' style='max-width:150px; margin-top:10px;' />";
		}
	}
	
	function sanitize_image($image, $option_name) {
		if (!empty($_FILES)) {
			if (isset($_FILES[$option_name]) && $_FILES[$option_name]['size'] > 0) {
				$image_id = media_handle_upload($option_name, 0);
				if (is_wp_error($image_id)) {
					add_settings_error($option_name, $option_name . '_error', 'Error uploading image.');
					return get_option($option_name); // Return existing image URL on error
				} else {
					return wp_get_attachment_url($image_id);
				}
			}
		}

		// If no file is uploaded, return the existing image URL
		return $image;
	}
	
	add_action('admin_enqueue_scripts', 'demijngang_enqueue_scripts');

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
	
	// Shortcodes
	add_action('init', 'demijngang_restaurantmenu_shortcodes');
	
	function demijngang_restaurantmenu_shortcodes() {
		add_shortcode('meal_1', 'demijngang_restaurantmenu_display_meal_1');
		add_shortcode('meal_2', 'demijngang_restaurantmenu_display_meal_2');
		
		add_shortcode('meal_1_title', 'demijngang_restaurantmenu_display_meal_1_title');
		add_shortcode('meal_1_description', 'demijngang_restaurantmenu_display_meal_1_description');
		add_shortcode('meal_1_image', 'demijngang_restaurantmenu_display_meal_1_image');
		
		add_shortcode('meal_2_title', 'demijngang_restaurantmenu_display_meal_2_title');
		add_shortcode('meal_2_description', 'demijngang_restaurantmenu_display_meal_2_description');
		add_shortcode('meal_2_image', 'demijngang_restaurantmenu_display_meal_2_image');
	}
	
	function demijngang_restaurantmenu_shortcode_display() {
		$value = get_option($parameter);
		return $value;
	}
	
	function demijngang_restaurantmenu_display_meal_1_title() {
		$title = get_option('meal_1_title');	
		return '<h2>' . esc_html($title) . '</h2>';
	}
	
	function demijngang_restaurantmenu_display_meal_1() {
		$meal_1_title = get_option('meal_1_title');
		$meal_1_description = get_option('meal_1_description');
		$meal_1_image = get_option('meal_1_image');

		ob_start();
		?>
		<div class="meal">
			<?php if ($meal_1_image): ?>
				<img src="<?php echo esc_url($meal_1_image); ?>" alt="<?php echo esc_attr($meal_1_title); ?>" style="max-width: 300px;">
			<?php endif; ?>
			<h2><?php echo esc_html($meal_1_title); ?></h2>
			<p><?php echo esc_html($meal_1_description); ?></p>
		</div>
		<?php
		return ob_get_clean();
	}
	
	function demijngang_restaurantmenu_display_meal_2() {
		$meal_2_title = get_option('meal_2_title');
		$meal_2_description = get_option('meal_2_description');
		$meal_2_image = get_option('meal_2_image');

		ob_start();
		?>
		<div class="meal">
			<?php if ($meal_2_image): ?>
				<img src="<?php echo esc_url($meal_2_image); ?>" alt="<?php echo esc_attr($meal_2_title); ?>" style="max-width: 300px;">
			<?php endif; ?>
			<h2><?php echo esc_html($meal_2_title); ?></h2>
			<p><?php echo esc_html($meal_2_description); ?></p>
		</div>
		<?php
		return ob_get_clean();
	}