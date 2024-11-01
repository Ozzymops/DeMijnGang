<?php	
	function demijngang_food_constructor() {
		add_submenu_page(
			'demijngang',
			'Restaurant',
			'Restaurant',
			'manage_options',
			'demijngang',
			'demijngang_food_page'
		);
	}
	add_action('admin_menu', 'demijngang_food_constructor');

	function demijngang_food_page() {
		demijngang_food_schedule_update();
		wp_enqueue_style('feature-restaurant', plugins_url( '/feature-restaurant.css', __FILE__ ), false, '1.0', 'all' );
		?>
			<div class="wrap">
				<h1>Maaltijden Menu</h1>
				<form method="post" action="options.php" enctype="multipart/form-data">
					<?php
						settings_fields('demijngang_food_options_group');
						do_settings_sections('demijngang_food');
					?>
					<table class="form-table">
						<tr>
							<th>Maaltijd</th>
							<th>Gerecht</th>
							<th>Beschrijving</th>
							<th>Foto</th>
						</tr>
						<!-- Lunch 1 -->
						<tr>
							<td><h2>Lunch 1</h2></td>
							<td>
								<input type="text" name="title-lunch_1" value="<?php echo esc_attr(get_option('title-lunch_1', '')); ?>" />
							</td>
							<td>
								<textarea name="description-lunch_1"><?php echo esc_textarea(get_option('description-lunch_1', '')); ?></textarea>
							</td>
							<td>
								<input type="file" name="photo-lunch_1" accept="image/*" />
							</td>
						</tr>
						<!-- Lunch 2 -->
						<tr>
							<td><h2>Lunch 2</h2></td>
							<td>
								<input type="text" name="title-lunch_2" value="<?php echo esc_attr(get_option('title-lunch_2', '')); ?>" />
							</td>
							<td>
								<textarea name="description-lunch_2"><?php echo esc_textarea(get_option('description-lunch_2', '')); ?></textarea>
							</td>
							<td>
								<input type="file" name="photo-lunch_2" accept="image/*" />
							</td>
						</tr>
						<!-- Avondeten 1 -->
						<tr>
							<td><h2>Avondeten 1</h2></td>
							<td>
								<input type="text" name="title-dinner_1" value="<?php echo esc_attr(get_option('title-dinner_1', '')); ?>" />
							</td>
							<td>
								<textarea name="description-dinner_1"><?php echo esc_textarea(get_option('description-dinner_1', '')); ?></textarea>
							</td>
							<td>
								<input type="file" name="photo-dinner_1" accept="image/*" />
							</td>
						</tr>
						<!-- Avondeten 2 -->
						<tr>
							<td><h2>Avondeten 2</h2></td>
							<td>
								<input type="text" name="title-dinner_2" value="<?php echo esc_attr(get_option('title-dinner_2', '')); ?>" />
							</td>
							<td>
								<textarea name="description-dinner_2"><?php echo esc_textarea(get_option('description-dinner_2', '')); ?></textarea>
							</td>
							<td>
								<input type="file" name="photo-dinner_2" accept="image/*" />
							</td>
						</tr>
						<!-- Avondeten 3 -->
						<tr>
							<td><h2>Avondeten 3</h2></td>
							<td>
								<input type="text" name="title-dinner_3" value="<?php echo esc_attr(get_option('title-dinner_3', '')); ?>" />
							</td>
							<td>
								<textarea name="description-dinner_3"><?php echo esc_textarea(get_option('description-dinner_3', '')); ?></textarea>
							</td>
							<td>
								<input type="file" name="photo-dinner_3" accept="image/*" />
							</td>
						</tr>
						<!-- Avondeten 4 -->
						<tr>
							<td><h2>Avondeten 4</h2></td>
							<td>
								<input type="text" name="title-dinner_4" value="<?php echo esc_attr(get_option('title-dinner_4', '')); ?>" />
							</td>
							<td>
								<textarea name="description-dinner_4"><?php echo esc_textarea(get_option('description-dinner_4', '')); ?></textarea>
							</td>
							<td>
								<input type="file" name="photo-dinner_4" accept="image/*" />
							</td>
						</tr>
						<!-- Avondeten 5 -->
						<tr>
							<td><h2>Avondeten 5</h2></td>
							<td>
								<input type="text" name="title-dinner_5" value="<?php echo esc_attr(get_option('title-dinner_5', '')); ?>" />
							</td>
							<td>
								<textarea name="description-dinner_5"><?php echo esc_textarea(get_option('description-dinner_5', '')); ?></textarea>
							</td>
							<td>
								<input type="file" name="photo-dinner_5" accept="image/*" />
							</td>
						</tr>
					</table>
					<?php submit_button(); ?>
				</form>
				<div class="examples">
					<h1>Voorbeelden / Huidig menu</h1>
					<div style="display: flex; justify-content: center;">
						<div style="text-align: center; padding: 25px;">
							<h2>Avondeten 1:</h2>
							<p style="font-size: 16px;"><?php echo get_option("title-dinner_1"); ?></p>
							<p><?php echo get_option("description-dinner_1"); ?></p>
							<img src="<?php echo get_option('photo-dinner_1'); ?>" />
						</div>
						<div style="text-align: center; padding: 25px;">
							<h2>Avondeten 2:</h2>
							<p style="font-size: 16px;"><?php echo get_option("title-dinner_2"); ?></p>
							<p><?php echo get_option("description-dinner_2"); ?></p>
							<img src="<?php echo get_option('photo-dinner_2'); ?>" />
						</div>
						<div style="text-align: center; padding: 25px;">
							<h2>Avondeten 3:</h2>
							<p style="font-size: 16px;"><?php echo get_option("title-dinner_3"); ?></p>
							<p><?php echo get_option("description-dinner_3"); ?></p>
							<img src="<?php echo get_option('photo-dinner_3'); ?>" />
						</div>
						<div style="text-align: center; padding: 25px;">
							<h2>Avondeten 4:</h2>
							<p style="font-size: 16px;"><?php echo get_option("title-dinner_4"); ?></p>
							<p><?php echo get_option("description-dinner_4"); ?></p>
							<img src="<?php echo get_option('photo-dinner_4'); ?>" />
						</div>
						<div style="text-align: center; padding: 25px;">
							<h2>Avondeten 5:</h2>
							<p style="font-size: 16px;"><?php echo get_option("title-dinner_5"); ?></p>
							<p><?php echo get_option("description-dinner_5"); ?></p>
							<img src="<?php echo get_option('photo-dinner_5'); ?>" />
						</div>
					</div>
					<div style="display: flex; justify-content: center;">
						<div style="text-align: center; padding: 25px;">
							<h2>Huidig avondeten:</h2>
							<h3 style="text-align: center;">Voor woensdag <?php $date = get_option('next_wednesday'); $formattedDate = null; if ($date && $date instanceof DateTime) { $formattedDate = $date->format('d/m'); } else { $formattedDate = 'Not Set'; } echo esc_html($formattedDate); ?></h3>
							<p style="font-size: 16px;"><?php echo get_option("title-dinner_current"); ?></p>
							<p><?php echo get_option("description-dinner_current"); ?></p>
							<img src="<?php echo get_option('photo-dinner_current'); ?>" />
						</div>
					</div>
					<hr />
					<h3 style="text-align: center;">Voor vrijdag <?php $date = get_option('next_friday'); $formattedDate = null; if ($date && $date instanceof DateTime) { $formattedDate = $date->format('d/m'); } else { $formattedDate = 'Not Set'; } echo esc_html($formattedDate); ?></h3>
					<div style="display: flex; justify-content: center;">
						<div style="text-align: center; padding: 25px;">
							<h2>Lunch 1:</h2>
							<p style="font-size: 16px;"><?php echo get_option("title-lunch_1"); ?></p>
							<p><?php echo get_option("description-lunch_1"); ?></p>
							<img src="<?php echo get_option('photo-lunch_1'); ?>" />
						</div>
						<div style="text-align: center; padding: 25px;">
							<h2>Lunch 2:</h2>
							<p style="font-size: 16px;"><?php echo get_option("title-lunch_2"); ?></p>
							<p><?php echo get_option("description-lunch_2"); ?></p>
							<img src="<?php echo get_option('photo-lunch_2'); ?>" />
						</div>
					</div>
				</div>
			</div>
		<?php
	}

	function demijngang_food_options() {
		add_settings_section('food_options_section', 'Maaltijden', null, 'demijngang_food');
		register_setting('demijngang_food_options_group', 'title-lunch_1', 'sanitize_text_field');
		register_setting('demijngang_food_options_group', 'description-lunch_1', 'sanitize-textarea-field');
		register_setting('demijngang_food_options_group', 'photo-lunch_1', function($image) { return sanitize_image($image, 'photo-lunch_1'); });

		register_setting('demijngang_food_options_group', 'title-lunch_2', 'sanitize_text_field');
		register_setting('demijngang_food_options_group', 'description-lunch_2', 'sanitize-textarea-field');
		register_setting('demijngang_food_options_group', 'photo-lunch_2', function($image) { return sanitize_image($image, 'photo-lunch_2'); });

		register_setting('demijngang_food_options_group', 'title-dinner_current');
		register_setting('demijngang_food_options_group', 'description-dinner_current');
		register_setting('demijngang_food_options_group', 'photo-dinner_current');

		register_setting('demijngang_food_options_group', 'title-dinner_1', 'sanitize_text_field');
		register_setting('demijngang_food_options_group', 'description-dinner_1', 'sanitize-textarea-field');
		register_setting('demijngang_food_options_group', 'photo-dinner_1', function($image) { return sanitize_image($image, 'photo-dinner_1'); });

		register_setting('demijngang_food_options_group', 'title-dinner_2', 'sanitize_text_field');
		register_setting('demijngang_food_options_group', 'description-dinner_2', 'sanitize-textarea-field');
		register_setting('demijngang_food_options_group', 'photo-dinner_2', function($image) { return sanitize_image($image, 'photo-dinner_2'); });

		register_setting('demijngang_food_options_group', 'title-dinner_3', 'sanitize_text_field');
		register_setting('demijngang_food_options_group', 'description-dinner_3', 'sanitize-textarea-field');
		register_setting('demijngang_food_options_group', 'photo-dinner_3', function($image) { return sanitize_image($image, 'photo-dinner_3'); });

		register_setting('demijngang_food_options_group', 'title-dinner_4', 'sanitize_text_field');
		register_setting('demijngang_food_options_group', 'description-dinner_4', 'sanitize-textarea-field');
		register_setting('demijngang_food_options_group', 'photo-dinner_4', function($image) { return sanitize_image($image, 'photo-dinner_4'); });

		register_setting('demijngang_food_options_group', 'title-dinner_5', 'sanitize_text_field');
		register_setting('demijngang_food_options_group', 'description-dinner_5', 'sanitize-textarea-field');
		register_setting('demijngang_food_options_group', 'photo-dinner_5', function($image) { return sanitize_image($image, 'photo-dinner_5'); });

		register_setting('demijngang_food_options_group', 'next_wednesday');
		register_setting('demijngang_food_options_group', 'next_friday');
	}
	add_action('admin_init', 'demijngang_food_options');

	function demijngang_food_options_callback($option, $type) {
		$content = get_option($option);

		switch($type) {
			case 0:
				echo sprintf("<input type='text' name='food_options_section[%s]' value='%s' />", $option, esc_attr($content));
				break;

			case 1:
				echo sprintf("<textarea name='%s'>%s</textarea>", $option, esc_textarea($content));
				break;

			case 2:
				echo sprintf("<input type='file' name='%s' accept='image/*' />", $option);
				if ($content) { echo sprintf("<br /><img src='%s' style='max-width: 150px; margin-top: 10px;' />", esc_url($content)); }
				break;

			default:
				echo sprintf("<input type='text' name='%s' value='%s' />", $option, esc_attr($content));
				break;
		}
	}

	function demijngang_food_shortcodes() {
		add_shortcode('title-lunch_1', function() { return get_option('title-lunch_1'); });
		add_shortcode('description-lunch_1', function() { return get_option('description-lunch_1'); });
		add_shortcode('photo-lunch_1', function() { return get_option('photo-lunch_1'); });

		add_shortcode('title-lunch_2', function() { return get_option('title-lunch_2'); });
		add_shortcode('description-lunch_2', function() { return get_option('description-lunch_2'); });
		add_shortcode('photo-lunch_2', function() { return get_option('photo-lunch_2'); });

		add_shortcode('title-dinner_current', function() { return get_option('title-dinner_current'); });
		add_shortcode('description-dinner_current', function() { return get_option('description-dinner_current'); });
		add_shortcode('photo-dinner_current', function() { return get_option('photo-dinner_current'); });

		add_shortcode('next_wednesday', function () { $date = get_option('next_wednesday'); return ($date && $date instanceof DateTime) ? $date->format('d/m') : 'Not Set'; });
		add_shortcode('next_friday', function () { $date = get_option('next_friday'); return ($date && $date instanceof DateTime) ? $date->format('d/m') : 'Not Set'; });
	}
	add_action('init', 'demijngang_food_shortcodes');

	function demijngang_food_schedule_update() {
		$titles = [
			1 => get_option('title-dinner_1'),
			2 => get_option('title-dinner_2'),
			3 => get_option('title-dinner_3'),
			4 => get_option('title-dinner_4'),
			5 => get_option('title-dinner_5'),
		];

		$descriptions = [
			1 => get_option('description-dinner_1'),
			2 => get_option('description-dinner_2'),
			3 => get_option('description-dinner_3'),
			4 => get_option('description-dinner_4'),
			5 => get_option('description-dinner_5'),
		];
		
		$images = [
			1 => get_option('photo-dinner_1'),
			2 => get_option('photo-dinner_2'),
			3 => get_option('photo-dinner_3'),
			4 => get_option('photo-dinner_4'),
			5 => get_option('photo-dinner_5'),
		];

		// get next instance of Wednesday and Friday
		$today = new DateTime();
		$nextWed = clone $today;
		$nextFri = clone $today;

		$nextWed->modify('next Wednesday');
		$nextFri->modify('next Friday');

		$week = demijngang_food_schedule_week($nextWed);
		update_option('title-dinner_current', isset($titles[$week]) ? $titles[$week] : '');
		update_option('description-dinner_current', isset($descriptions[$week]) ? $descriptions[$week] : '');
		update_option('photo-dinner_current', isset($images[$week]) ? $images[$week] : '');
		
		update_option('next_wednesday', $nextWed);
		update_option('next_friday', $nextFri);
	}

	function demijngang_food_schedule_week($occurence) {
		return ceil($occurence->format('j') / 7);
	}

	function demijngang_food_schedule_activate() {
		if (!wp_next_scheduled('demijngang_food_schedule_update')) {
			wp_schedule_event(strtotime('next Saturday'), 'weekly', 'demijngang_food_schedule_update');
		}
	}
	register_activation_hook(__FILE__, 'demijngang_food_schedule_activate');

	function demijngang_food_schedule_deactivate() {
		wp_clear_scheduled_hook('demijngang_food_schedule_update');
	}
	register_deactivation_hook(__FILE__, 'demijngang_food_schedule_deactivate');

	function sanitize_image($image, $option_name) {
		if (!empty($_FILES) && isset($_FILES[$option_name]) && $_FILES[$option_name]['size'] > 0) {
			$image_id = media_handle_upload($option_name, 0);
			
			if (is_wp_error($image_id)) {
				add_settings_error($option_name, $option_name . '_error', 'Error uploading image.');
				return !empty($image) ? $image : plugin_dir_url(__FILE__) . 'images/placeholder.jpg';
			}
			else
			{
				return wp_get_attachment_url($image_id);
			}
		}

		$current_image = get_option($option_name);
		return !empty($current_image) ? $current_image : plugin_dir_url(__FILE__) . 'images/placeholder.jpg';
	}

	function demijngang_enqueue_scripts($hook) {
		if ($hook !== 'demijngang_menu' && $hook !== 'demijngang_restaurantmenu_page') {
			return;
		}

		wp_enqueue_media();
	}
	add_action('admin_enqueue_scripts', 'demijngang_enqueue_scripts');