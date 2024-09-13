<?php
/**
 * The template for displaying all pages
 *
 * This is the template that displays all pages by default.
 * Please note that this is the WordPress construct of pages
 * and that other 'pages' on your WordPress site will use a
 * different template.
 *
 * @package Understrap
 */

// Exit if accessed directly.
defined( 'ABSPATH' ) || exit;

get_header();

$container = get_theme_mod( 'understrap_container_type' );

?>

<div class="wrapper" id="page-wrapper">

	<div class="<?php echo esc_attr( $container ); ?>" id="content" tabindex="-1">

		<div class="row">

			<?php
			// Do the left sidebar check and open div#primary.
			get_template_part( 'templates/left-sidebar-check' );
			?>

			<main class="site-main" id="main">

				<?php if (is_front_page()) { ?>
					<div class="frontpage-container">
						<h1 class="title">De MijnGang</h1>
						<h2 class="subtitle">Van O.V.S. naar De MijnGang</h2>
						<p class="blurb-txt">Stichting De MijnGang is gevestigd in het zuidelijkste puntje van Nederland, Heerlen; Heerlen-Noord om precies te zijn.<br /><br />Wij zijn gestart met ons te richten op het sociale welzijn van ouderen in de buurt om zo eenzaamheid te minimaliseren. Samenzijn is na de coronacrisis niet meer vanzelfsprekend en al helemaal niet onder ouderen!<br /><br />Samen is toch zoveel leuker dan alleen?</p>
						<iframe class="map-embed" loading="lazy" allowfullscreen src="https://www.google.com/maps/embed/v1/place?q=place_id:ChIJ8b-5eXq9wEcRmevC_epgSrs&key=AIzaSyApX6kuZsXjGYNDxRKIELKivly8wwksqaM"></iframe>
						<img class="building-img" src="<?php echo get_stylesheet_directory_uri();?>/img/building.webp" />
						<img class="blurb-img" src="<?php echo get_stylesheet_directory_uri();?>/img/div.png" />
						<img class="map-img" src="<?php echo get_stylesheet_directory_uri();?>/img/div.png" />
					</div>					
				<?php } ?>

				<?php while ( have_posts() ) {
					the_post();
					get_template_part( 'templates/loop/content-page' );

					// If comments are open or we have at least one comment, load up the comment template.
					if ( comments_open() || get_comments_number() ) {
						comments_template();
					}
				}
				?>

			</main>

			<?php
			// Do the right sidebar check and close div#primary.
			get_template_part( 'templates/right-sidebar-check' );
			?>

		</div><!-- .row -->

	</div><!-- #content -->

</div><!-- #page-wrapper -->

<?php
get_footer();
