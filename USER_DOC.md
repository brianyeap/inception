# USER_DOC — Inception (User/Admin Guide)

## What this stack provides

- **NGINX**: the only public entrypoint, serving HTTPS on port **443** (TLSv1.2/1.3).
- **WordPress + PHP-FPM**: runs the WordPress application (no nginx in this container).
- **MariaDB**: stores WordPress data (no nginx in this container).
- **Docker network**: containers communicate internally by service name.
- **Persistent data**: WordPress files + MariaDB data are stored in Docker named volumes.

## Start / Stop

From the repository root:

- Start (build if needed): `make`
- Stop: `make down`
- Stop + remove containers/networks: `make clean`
- Full reset (also removes volumes): `make fclean`

## Access the website and admin panel

1) Set your domain to point to your VM IP (example):

- Edit your VM `/etc/hosts` and map `bryeap.42.fr` to your VM IP.

2) Open:

- Website: `https://bryeap.42.fr`
- WordPress admin: `https://bryeap.42.fr/wp-admin`

Note: the TLS certificate is self-signed, so your browser will show a warning.

## Credentials: where to find and manage them

- Local configuration is read from `srcs/.env` (this file is git-ignored).
- Use `srcs/.env-example` as a template and create your own `srcs/.env`.

Typical values you’ll manage:

- Database: `DB_NAME`, `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_ROOT_PASSWORD`
- WordPress admin + user: `WP_ADMIN_*`, `WP_USER_*`
- Domain: `DOMAIN_NAME`

## Check that services are running correctly

- Container status: `docker compose -f srcs/docker-compose.yml ps`
- Logs:
  - Nginx: `docker logs nginx`
  - WordPress: `docker logs wordpress`
  - MariaDB: `docker logs mariadb`
- Quick HTTPS check from the VM:
  - `curl -kI https://bryeap.42.fr`

