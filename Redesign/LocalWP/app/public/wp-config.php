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
define( 'AUTH_KEY',          '!pD5piw*8(>IY5U;d}a(47KOvH9g<Fv<)K-geKP4Yh{Bt@%/M,P9MdL4qsDE[p}>' );
define( 'SECURE_AUTH_KEY',   '&F@?|~e@(DhJH0c[S^9|{J5EZyFJ/1jpm;ZkeA~LEQ.6bgq5q4ZaMEIIGBE![?7.' );
define( 'LOGGED_IN_KEY',     '-{BR]_SiKZcLE5C(t&iNL,E!S],EPI*S,I <-k =[jZ{Z1@`KkMWJpj-}MYj[O.L' );
define( 'NONCE_KEY',         'km8[|.7X8h)0iad+Ar=>B%klAE00E^GA^tdN&vg|s;Qe~dU!h%e`!zRA&zp/@IsF' );
define( 'AUTH_SALT',         'eG#XgJkQXIo/SnVPf2u2 Cfc)^|6O;s Zk kv)*jqn>`gIn `rT_$Mru7>LVf&Sb' );
define( 'SECURE_AUTH_SALT',  'pxfH8WXQ DvTxh5^!OT=}]9I^4IY1nbY5cFe_e@m`N1Mtf5Z`rjZeCjR,r?q%maS' );
define( 'LOGGED_IN_SALT',    '|qxoI$.EAl-yCWQnsb#,DgT){#.xb:`FqLf<y%4Z1O7v2T4-;U%zA%8{`?}gMB]J' );
define( 'NONCE_SALT',        'v/5FZ=a:{ux1k4i(G]LtFk77Ns0Sxgv8l| .ioTDLE8GNC!xM,f6xF_]z]`.EVhC' );
define( 'WP_CACHE_KEY_SALT', 'Ci@4q;7+O&t&l`sO0&/J^3P*%Rjos%e-TuQ]v+#}8/5oE@y}K]@b}b[rd.e}z1Me' );


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
