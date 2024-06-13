<?php
/**
 * The template for displaying the footer
 *
 * Contains the closing of the #content div and all content after
 *
 * @package Understrap
 */

// Exit if accessed directly.
defined( 'ABSPATH' ) || exit;

$container = get_theme_mod( 'understrap_container_type' );
?>

<?php get_template_part( 'templates/sidebar-templates/sidebar', 'footerfull' ); ?>

<div class="wrapper" id="wrapper-footer">

	<div></div><!-- Hopefully a solution to stop socials from being eaten -->
	<div class="footer-links">
		<div class="footer-links-email">
			<a href="mailto:demijngang@outlook.com"><i class="fas fa-at"></i></a>
		</div>
		<div class="footer-links-facebook">
			<a href="https://www.facebook.com/demijngang/"><i class="fab fa-facebook"></i></a>
		</div>
	</div>
	<div class="footer-information">
		<i class="far fa-copyright"></i>
		<p>De MijnGang</p>
	</div>
	<div class="footer-information">
		<a href="http://de-mijngang.local/wpautoterms/privacy-policy">Privacy</a>
		<a href="http://de-mijngang.local/wpautoterms/terms-and-conditions">Voorwaarden</a>
	</div>

</div><!-- #wrapper-footer -->

<?php // Closing div#page from header.php. ?>
</div><!-- #page -->

<?php wp_footer(); ?>

</body>

</html>

