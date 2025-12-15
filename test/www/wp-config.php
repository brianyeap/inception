<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'wppassword' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

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
define( 'AUTH_KEY',         'O|L=?6zV(PE8Dxr) Y}}iso$G;vd_a.:h/]Hui|4}Zois55G7haZ?DN4sMuKugpK' );
define( 'SECURE_AUTH_KEY',  'MRhqAm1Y9dsqeKf>paptjlvX>RSYKf&v{ fHElp|HPTLSSi)s:% q?q4jDILNQZW' );
define( 'LOGGED_IN_KEY',    'CNR/]U#L*CJmoCK i{O+&m8:NyD+RD%bzO0-5Vd2P.?nrCg&:tmllz47Nb};;+|I' );
define( 'NONCE_KEY',        '$ HaK3pz>#ffTdB_ZM<LM1fJalvN1,F=+Q%- 0OYexyb+fr09}yexgy&v<[Zk7kY' );
define( 'AUTH_SALT',        'UswY>yk4,$s%U{=__!b*H6z1A=MR9I-)NaN?%7?lD 0q5+rT;o4K$Xb0O<*I7n<D' );
define( 'SECURE_AUTH_SALT', 'Om,Bv13SK1h>``=N&iaJ67#m1w+aQKZt{;$V3PkSM&5#T#R!H<-G5 VXHiVZ)TZ[' );
define( 'LOGGED_IN_SALT',   'cwPanWN%bsj6Q|AK0.KNv o(m]D_<h%E2|i/o+34&,<U! L2[[J-lil:5tp?!he2' );
define( 'NONCE_SALT',       '-.Q:QJ/@8|Ve(/w9dj3[8qd6)(35GmJ84Aos7~,`H>FWH1#-,,Df[h+R$&a&_X{r' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

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
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
