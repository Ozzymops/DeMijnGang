<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'local' );

/** Database username */
define( 'DB_USER', 'root' );

/** Database password */
define( 'DB_PASSWORD', 'root' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '}_WCFQU4#B)<q -@d=REmncIL=vc|Mg@D]0n!+Zlsn 9P_CNp4rDc%yP#lkI.Tkj' );
define( 'SECURE_AUTH_KEY',   'rCP+Nq_clNx%$gtl%H>Fz]{m<x1:1+ >7D({609o$^@`8GR R`Jw5,fCt/svMGU*' );
define( 'LOGGED_IN_KEY',     '[HZfi*v>[yBTVTV/PCe<L=1y(nZ/;mx6gD;xdA0[{^7aA=detUL=hJ*Sa$@F>5Nn' );
define( 'NONCE_KEY',         'T@o;Pv-69]cX&g+jMr38/<&`!w|GhM=rnu[LB2=bt4~vZdeA8srn.m#6`)Z@q{%_' );
define( 'AUTH_SALT',         'GeN`&<Wt i2l$|=-<Lra8`:sJG+o{o96:?8isF ]Cjo*[< ZAVni/M3Lt2^-l-5~' );
define( 'SECURE_AUTH_SALT',  '*yWTC:lzY.Lj4vvDAkpF$vE1Eg_lvV7V!<T._{4^/^XS`>GEN@}HU|Jop@/EDX6B' );
define( 'LOGGED_IN_SALT',    '!L+%x(]`vqRY,Y-Vkz<0zRyz~i;aCWGU=vS,eKQ)NJy]Ph2;yI3nbK!TmGWl|IZA' );
define( 'NONCE_SALT',        '|$,g24uW^))?p|t_j=`>8|0k#^|YOUYkKUS$pU-;;_rc1 Cj5u^@r)s@IW2E(-jZ' );
define( 'WP_CACHE_KEY_SALT', '1P~jBIh@[Ni 51Fdy`i>)l1pUw=*hu^$.E^w.bRbwch^T$4aoNq1li(:;!c8,GK/' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

define( 'WP_ENVIRONMENT_TYPE', 'local' );
/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
