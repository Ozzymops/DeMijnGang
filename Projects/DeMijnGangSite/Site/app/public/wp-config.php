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
define( 'AUTH_KEY',          '/dx>9Lc|+06DTB7q[)9[c!In;1oLb%xhR!gGD`qav3J*r-z^>kp3eSG;bw?694`C' );
define( 'SECURE_AUTH_KEY',   '_6^T c0L8xcwxb+xh3Gv0aMYo5rtZxqKjAw[];;|4-1Ka<vcxI -mT*:Ef6Qm&(Y' );
define( 'LOGGED_IN_KEY',     'xs>uD`5>lm$7X[R_Mb:NnW4)wfl@QoP#9RJ;z@)1n%fKVR.Q2j{|eJ3KG`)^myi=' );
define( 'NONCE_KEY',         'J&hAw5.SXr3K@y[KtUC5rB[ SfC)eFl(C&S`H*;?utz;6}9W9%]l@Bs>{Y 5hH}D' );
define( 'AUTH_SALT',         '3XlH*=R-NrzDcK9`B.]i$k)6:Q->@udW35H7l[W6dB8E?$yN`N3.//>+Sh{TCT%(' );
define( 'SECURE_AUTH_SALT',  '<l{tPs$Fg6FyVa^y&MiSXt]2]5rFX|gE`tzP57kgM4z WLBQT(p?L+,><Hn#0*q4' );
define( 'LOGGED_IN_SALT',    '+7_Wtw4nET_nSJL[AdK$j?t~/drF|D~L]}-QU%N.x)-l^S=!@RRAOq!UVxAV^})p' );
define( 'NONCE_SALT',        'sIy&x`MuEf(A*i[`~2bLbXeVpEvwuYemV&f1cq]/Gr0g`Gz.-2epjvGZQ2FMr+f]' );
define( 'WP_CACHE_KEY_SALT', '2tRP`8m^_Ex@RhD{uLl!:26TNf!JG,?LxqHj+.nUqi2dJV^J/eb+h+v]hgI5z1Tb' );


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
