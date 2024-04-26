<?php
// Normalize.css
function NormalizeCSS() {
    wp_enqueue_style('normalize-styles', "https://cdnjs.cloudflare.com/ajax/libs/normalize/7.0.0/normalize.min.css");
}
add_action('wp_enqueue_scripts', 'NormalizeCSS');

// Sidebar
function Sidebar() {
    register_sidebar(array(
        'name' => 'Sidebar',
        'id' => 'sidebar',
        'before_widget' => '<div>',
        'after_widget' => '</div>',
        'before_title' => '<h2>',
        'after_title' => '</h2>',
    ));
}
add_action('widgets_init', 'Sidebar');

// Navbar
function Navbar() {
    register_nav_menu('header-menu', __('Header Menu'));
}
add_action('init', 'Navbar');

// Image embed without site name
update_option('upload_url_path', '/wp-content/uploads');