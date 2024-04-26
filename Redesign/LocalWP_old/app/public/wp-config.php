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
define( 'AUTH_KEY',          '!OQTT}Oh%l:D4NjPPYx-^}t]LGs)zIDTbOH_f^ef00tNID(0>b(ef5GI)GJEyH`s' );
define( 'SECURE_AUTH_KEY',   'w47Tbn/1Mg*x~f>G^;2K@n}I:oJA!uXT3Lh[3{uQ8O.60J}pyLx/U ?$-HMt6%H(' );
define( 'LOGGED_IN_KEY',     'bom9n+mryT>VP<Z<mmx:s?L=kZo9cg JbXpC$t6.4Jwtps)XFRI:g4bm^O}TP/hx' );
define( 'NONCE_KEY',         '+Wp`$j{=~6jCel`fN )]loU?t2,|951{8<Wo>o+/v)Q~@PPNmM,7[(`Mmm!Pvn$A' );
define( 'AUTH_SALT',         '*`cNJcI5jw}MWn$s1s2{D0FrP}b{R/T)WTMUnE!5q,=Yev6GaR(LI,-r-e_f9FO ' );
define( 'SECURE_AUTH_SALT',  'CV+.UFf-s+dHG5cF5V:nIGezuOX4-{zZtSGKSqg_2U^8S:}kzL5ZtiIq+y5#>Xex' );
define( 'LOGGED_IN_SALT',    '=<C0!:SBb-VxXU`RmD}]inm4HmRZeu3@T`GS6G(C&PiMS/JVlQ9n@x%Tw9Ao,4S?' );
define( 'NONCE_SALT',        'MIkuVCdT]E*%m$ov6XRVk|zg/p8C%96O!wIwnJ/kvsB4lD<{W8X1>d7`5Njv(lgI' );
define( 'WP_CACHE_KEY_SALT', 'k&a`1WYLX3LaW;Z3jX8>7gsY|*Sy{^c8*Pb5iox.jSH2qRao++EXu/hmsp16A.N]' );


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
