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
define( 'AUTH_KEY',          '[E(&S<1hLp8C)|RVL_GQ2+y`FeiF],^k-#Faqa{=k_hsizIOAOGWTyZ5%q,lJ+ M' );
define( 'SECURE_AUTH_KEY',   'T+e[9G=wVajvs1dME?mjsVk[,a7R)uK~$AWQL8.PH5R:5`S>8=Mit[2m<i#JW&4G' );
define( 'LOGGED_IN_KEY',     '7NTs_ZorQ>V@,Bg))%|e)boXR4LH+}F$Q&:)HnTW=kPOtZ?9pXQl*E`lyI<n[%@ ' );
define( 'NONCE_KEY',         'xHS[o;@I?KfHQnmxdv9E8aNLo 6X7EADhc]S(3}KQFCK,W)1 ShiqZ`kc|EkC24O' );
define( 'AUTH_SALT',         '}V*iUQ(RY6knI]J3zn=P%+cO6y#sFE/B/3K_KIT9x.>Rt*3CGVWY:@P|ph2Ed.W!' );
define( 'SECURE_AUTH_SALT',  'Z PtG1vdy2+ARAgzz%WWH} -UoUtI[uxZ=G`PQxaYVIQ&d>|uSVxhiSF(~@$&k.Z' );
define( 'LOGGED_IN_SALT',    '%ZdsL=9RH9Q_495XI)T<7Hu6E3. 9lS)OgRLpk?zFFI5aOG6rQYVF81icczwQN!s' );
define( 'NONCE_SALT',        'O4l?-i$,6vHmfedi. uv0H&xZA.-oz=p$y,t8TGM1l_,!x7R10]]m*Nrm2[3rqV`' );
define( 'WP_CACHE_KEY_SALT', 's,cEv]6+xBbJT[H&PNQvx$1Q%etQ_5t&P3*I!z`8lH$-lpP*#^jR}(tUHGY0<}tf' );


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
