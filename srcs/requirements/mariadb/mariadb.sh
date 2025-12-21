#!/bin/sh
set -eu

: "${DB_NAME:?missing DB_NAME}"
: "${MYSQL_USER:?missing MYSQL_USER}"
: "${MYSQL_PASSWORD:?missing MYSQL_PASSWORD}"
: "${MYSQL_ROOT_PASSWORD:?missing MYSQL_ROOT_PASSWORD}"

DATADIR=/var/lib/mysql
RUNDIR=/run/mysqld
SOCKET=$RUNDIR/mysqld.sock
MARKER=$DATADIR/.inception_initialized

mkdir -p "$RUNDIR"
chown -R mysql:mysql "$RUNDIR"

# Init only if we have not successfully done the SQL setup yet
if [ ! -f "$MARKER" ]; then
  # If the system tables are missing, create them
  if [ ! -d "$DATADIR/mysql" ]; then
    mariadb-install-db --user=mysql --datadir="$DATADIR" >/dev/null
  fi

  # Start a temporary server on a local socket only
  mariadbd --user=mysql --datadir="$DATADIR" --skip-networking --socket="$SOCKET" &
  pid=$!

  # Wait until the socket server is ready
  for i in $(seq 1 30); do
    mariadb-admin --socket="$SOCKET" ping >/dev/null 2>&1 && break
    [ "$i" -eq 30 ] && echo "Temp MariaDB not ready" && exit 1
    sleep 1
  done

  # Run init SQL
  mariadb --socket="$SOCKET" -uroot <<-SQL
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${MYSQL_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
SQL

  # Mark init as done
  touch "$MARKER"

  # Stop temp server
  mariadb-admin --socket="$SOCKET" -uroot -p"$MYSQL_ROOT_PASSWORD" shutdown
  wait "$pid"
fi

echo "Start MariaDB..."
exec mariadbd --user=mysql --datadir="$DATADIR" --bind-address=0.0.0.0
