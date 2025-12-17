#!/bin/sh
set -eu

: "${DB_NAME:?missing DB_NAME}"
: "${MYSQL_USER:?missing MYSQL_USER}"
: "${MYSQL_PASSWORD:?missing MYSQL_PASSWORD}"
: "${MYSQL_ROOT_PASSWORD:?missing MYSQL_ROOT_PASSWORD}"

DATADIR=/var/lib/mysql
SOCKET=/run/mysqld/mysqld.sock

mkdir -p /run/mysqld					# -p if not exist create else do ntg
chown -R mysql:mysql /run/mysqld		# Setting perm for mysql user (default user for mariadb)

if [ ! -d "$DATADIR/mysql" ]; then		# If mysql has not been init then do
  mariadb-install-db --user=mysql --datadir="$DATADIR" >/dev/null	# Create all the files for mariadb send logs to dev/null
  mariadbd --user=mysql --datadir="$DATADIR" --skip-networking --socket="$SOCKET" & # socker only no networking
  pid=$!

  mariadb --socket="$SOCKET" -uroot <<-SQL
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
SQL

  # @'%' for connection from all IP in docker like wordpress
  # .* All tables

  mariadb-admin --socket="$SOCKET" shutdown
  wait "$pid"
fi

echo "Start MariaDB..."
exec mariadbd --user=mysql --datadir="$DATADIR" --bind-address=0.0.0.0
