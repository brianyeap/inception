#!/bin/sh
set -e

# Use env vars from docker-compose (with defaults if missing)
: "${MARIADB_ROOT_PASSWORD:=root}"
: "${MARIADB_DATABASE:=wordpress}"
: "${MARIADB_USER:=wpuser}"
: "${MARIADB_PASSWORD:=wppassword}"

DATADIR="/var/lib/mysql"

# Ensure runtime dirs exist and belong to mysql
mkdir -p /run/mysqld "$DATADIR"
chown -R mysql:mysql /run/mysqld "$DATADIR"

# If no system tables yet, we assume first run
if [ ! -d "${DATADIR}/mysql" ]; then
  echo "Initializing MariaDB data directory in ${DATADIR}..."
  mariadb-install-db --user=mysql --datadir="${DATADIR}" --skip-test-db

  echo "Starting temporary MariaDB..."
  mysqld --user=mysql --datadir="${DATADIR}" --skip-networking &
  pid="$!"

  echo "Waiting for MariaDB to accept connections..."
  for i in $(seq 30); do
    if mariadb -uroot -e "SELECT 1" >/dev/null 2>&1; then
      break
    fi
    echo "  still waiting..."
    sleep 1
  done

  echo "Configuring database and user..."
  mariadb <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO '${MARIADB_USER}'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL

  echo "Shutting down temporary MariaDB..."
  mariadb-admin -uroot -p"${MARIADB_ROOT_PASSWORD}" shutdown || true
  wait "$pid"
fi

echo "Starting MariaDB in normal mode..."
exec mysqld --user=mysql --datadir="${DATADIR}" --bind-address=0.0.0.0
