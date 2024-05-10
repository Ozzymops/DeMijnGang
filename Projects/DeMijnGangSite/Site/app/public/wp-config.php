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
define( 'AUTH_KEY',          'LR:u0kDN,u^#MXx$UCNI0|Q&-[thGsJ(dub1L#3<v{V]4OSBs>$>/=D}Y%BK/#/{' );
define( 'SECURE_AUTH_KEY',   ':cY]$^@{w{rcE=NJUC9rX!,/wWyZM%&Qv9t;ukG>BW;9L&A 8n#=d{HKnsC]em<k' );
define( 'LOGGED_IN_KEY',     ')UjtcI8QpAXHMdpN](67)>ATybtiUI`R6`S<JJqa;*8i!PO&c:!hsrJ>2j)YYPt_' );
define( 'NONCE_KEY',         '<:]y>_+U}yjM-8tb0EO^M=w U)IvPl5RR?^cuj0pTFfe).jXbnZHfBx!%IPI@=o9' );
define( 'AUTH_SALT',         '*dksq5Mok8+6}!.(a8;w4$=^qmU@po0p.iRn]{y@E2`U2Gzs9&BWzxr;nLi_G;zv' );
define( 'SECURE_AUTH_SALT',  'kF[8NihC7B w4XyC~bpahcl}bR.UlJ;nA<-YCo4}e6P</6[^>[fzE)VPkVav{6Fs' );
define( 'LOGGED_IN_SALT',    '2_sYOr%40#=I>F:vFz&U||1~Hgr&#8w>;K{MD/k-|e8BQgWB$l@p%osKm<wB?=26' );
define( 'NONCE_SALT',        'Jd+LV=.%k_<*AV5c6=aaD!*%H&C^$@Ujn)D0#:@e=qYZ)YcIl6%~AK_9.*bPtkF-' );
define( 'WP_CACHE_KEY_SALT', 'OD,$1Ey%vi3m=--)YHftRk}$:[7$-Hs*u|5E<*+SCDX%reiS)nE(#oRX`XM|F.au' );


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
