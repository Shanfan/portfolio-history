<?php
/** 
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information by
 * visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'chitchy');

/** MySQL database username */
define('DB_USER', 'chitchy');

/** MySQL database password */
define('DB_PASSWORD', 'alone.4.Ever');

/** MySQL hostname */
define('DB_HOST', 'chitchy.db.4713308.hostedresource.com');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',        'I|jb&c!)+~nn!7%hkNoGW-#?>4i)D-(IoM!6n7G]DAi]F,=iTzP;`pG&][zxy(B{');
define('SECURE_AUTH_KEY', 'ZoBz[tG+f5y<oP|p;LfXfGTpy6{kPJ<V#I#l[hL(~z?PBcj+lJ5EtGHgM6D%p+yv');
define('LOGGED_IN_KEY',   'BF`5RvOJ_<ho<@K<u#Rv*:ZC>n(UWA;|Ke5J;^4BrYg.903OjB^F:,K<4_S`vtJM');
define('NONCE_KEY',       'l<W?Oz9!Dg0O* ]O`Y<K1k+},1)vT1qc$aQIh12UhVi|2W+ !uv*z@l!<&dv0`3S');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress.  A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de.mo to wp-content/languages and set WPLANG to 'de' to enable German
 * language support.
 */
define ('WPLANG', '');

/* That's all, stop editing! Happy blogging. */

/** WordPress absolute path to the Wordpress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
