# DEV_DOC — Inception (Developer Guide)

## Prerequisites

- A Linux VM (required by the subject)
- Docker Engine + Docker Compose plugin
- `make`

## Repo structure (key files)

- `Makefile`: entrypoint for building/starting/stopping the stack
- `srcs/docker-compose.yml`: Compose definition (services, volumes, network)
- `srcs/.env-example`: template for environment variables
- `srcs/requirements/*`: Dockerfiles and init scripts per service

## Environment setup (from scratch)

1) Create host folders for persistent data (replace `<login>`):

- `/home/<login>/data/mysql`
- `/home/<login>/data/wordpress`

2) Create the environment file:

- `cp srcs/.env-example srcs/.env`
- Edit `srcs/.env` and set all required variables.

3) Point the domain to your VM IP:

- Add an entry in `/etc/hosts` for `<login>.42.fr`.

## Build and launch

From the repository root:

- Build + start: `make`
- Rebuild: `make re`

## Useful Docker/Compose commands

- List containers: `docker compose -f srcs/docker-compose.yml ps`

## Data persistence (where data lives)

Two **Docker named volumes** are used:

- `mariadb_data` → MariaDB data directory (`/var/lib/mysql`)
- `wordpress_data` → WordPress files (`/var/www/html`)

They are configured to store data under `/home/<login>/data/...` on the host VM.

## Reset / cleanup

- Stop: `make down`
- Remove containers + network: `make clean`
- Remove containers + network + volumes: `make fclean`

If you need to fully wipe data, also remove the host directories:

- `sudo rm -rf /home/<login>/data/mysql /home/<login>/data/wordpress`

