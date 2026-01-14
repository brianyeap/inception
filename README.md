*This project has been created as part of the 42 curriculum by bryeap.*

## Description
This project sets up a small Docker infrastructure inside a Virtual Machine:
- **NGINX** as the only entrypoint on **443** with **TLSv1.3**
- **WordPress + php-fpm** (no nginx in this container)
- **MariaDB** (no nginx in this container)
- A Docker **network** connects services internally
- Two **volumes** persist data: database + WordPress files

## Required Concepts

### Virtual Machines vs Docker
- **VM**: full OS isolation, consistent Linux environment for the project.
- **Docker**: lightweight containers sharing the host kernel, fast to build/run.

### Environment Variables
- **.env**: store non-sensitive config (domain, DB name, user).

### Docker Network vs Host Network
- **Docker network**: containers talk internally by service name; only nginx is exposed.
- **Host network**: no isolation; forbidden by the subject (`network: host`).

### Docker Volumes vs Bind Mounts
- **Volumes**: Docker-managed persistent data (best for DB + wp-content).
- **Bind mounts**: direct host folder mapping; more fragile (permissions/path issues).

### Secrets vs Environment Variables
- **Environment variables (.env)** are easy to use for configuration, but they can be leaked if the file is accidentally committed.
- **Docker secrets** store sensitive values in files mounted at runtime (e.g. `/run/secrets/...`) which reduces the risk of exposing credentials in the repository.
- In this project, `.env` is used for configuration and is excluded from git via `.gitignore`. No credentials are hardcoded in Dockerfiles.


## Instructions
Replace `<user>` with your VM user.

```bash
sudo mkdir -p /home/<user>/data/mysql
sudo mkdir -p /home/<user>/data/wordpress

cd srcs
mv .env-example .env
nano .env # edit .env values

# build and start container
docker compose up -d --build

# Stop container
docker compose down

# Stop contaner and delete volumes
docker compose down -v
```

## Data persistence (Bind mounts)
Project data is stored on the VM host under:
- `/home/<user>/data/mysql` (MariaDB data)
- `/home/<user>/data/wordpress` (WordPress files)

`docker compose down -v` removes Docker volumes, but it does **not** delete these host folders.  
To fully reset the project, delete the folders manually:

```bash
sudo rm -rf /home/<user>/data/mysql /home/<user>/data/wordpress
```

## Resources
- Docker documentation (Dockerfiles, networking)
- Docker Compose documentation
- NGINX documentation (TLS configuration)
- WordPress documentation
- WP-CLI documentation

## Youtube videos
- https://www.youtube.com/watch?v=DQdB7wFEygo&t=575s
- https://www.youtube.com/watch?v=ZpZtxfmCfMg
- https://www.youtube.com/watch?v=38q5YRLzqD8
- https://www.youtube.com/watch?v=epUqbtQSx_g&t=229s
- https://www.youtube.com/watch?v=gEceSAJI_3s

## AI Usage
AI was used to:
- Outline the README structure based on the subject requirements
- Help explain required Docker concepts (VM vs Docker, networks, persistence)

All configuration and scripts were reviewed and tested manually.
