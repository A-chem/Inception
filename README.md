*This project has been created as part of the 42 curriculum by achemlal.*

# Inception

## Description

Inception is a System Administration project from the 42 curriculum focused on Docker and container orchestration.

The goal of the project is to build a secure and isolated infrastructure using Docker containers.  
Each service runs inside its own dedicated container and communicates through a Docker network.

The infrastructure includes:

- NGINX
- WordPress + PHP-FPM
- MariaDB
- Docker Volumes
- Docker Network
- TLS encryption

This project helps understand:

- Docker architecture
- Containerization
- Service isolation
- Networking
- Volumes and persistence
- Reverse proxy
- Infrastructure automation

---

# Project Architecture

```text
                 HTTPS :443
                      |
                +-----------+
                |   NGINX   |
                +-----------+
                      |
             -------------------
             |                 |
      +-------------+   +-------------+
      | WordPress   |   |   MariaDB   |
      |  PHP-FPM    |   |   Database  |
      +-------------+   +-------------+

              Docker Network

Volumes:
- wordpress_data
- mariadb_data
```

---

# Services

## NGINX

The NGINX container is the only public entrypoint of the infrastructure.

Responsibilities:

- Handle HTTPS requests
- Manage TLS encryption
- Reverse proxy requests
- Serve WordPress files
- Communicate with PHP-FPM

### Why NGINX?

NGINX is:

- lightweight
- fast
- secure
- commonly used in production

---

## WordPress + PHP-FPM

This container contains:

- WordPress
- PHP-FPM

Responsibilities:

- Execute PHP scripts
- Run WordPress logic
- Connect to MariaDB

### Why PHP-FPM?

PHP-FPM improves:

- performance
- process management
- stability

NGINX communicates with PHP-FPM using FastCGI.

---

## MariaDB

MariaDB is the SQL database server.

Responsibilities:

- Store WordPress data
- Manage SQL queries
- Handle authentication and permissions

---

# Instructions

## Clone Repository

```bash
git clone <repository_url>
cd inception
```

---

## Project Structure

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
├── srcs/
│   ├── .env
│   ├── docker-compose.yml
│   └── requirements/
│       ├── nginx/
│       ├── mariadb/
│       └── wordpress/
```

---

## Configure Environment Variables

Create:

```bash
srcs/.env
```

Example:

```env
DOMAIN_NAME=achemlal.42.fr

MYSQL_DATABASE=wordpress
MYSQL_USER=user42
MYSQL_HOST=mariadb

WP_TITLE=Inception
WP_ADMIN_USER=superuser
WP_ADMIN_EMAIL=admin@student.42.fr

WP_USER=user42
WP_USER_EMAIL=user42@student.42.fr
```

---

## Configure Secrets

Create:

```text
secrets/
├── db_password.txt
├── db_root_password.txt
└── credentials.txt
```

---

## Build and Start Infrastructure

```bash
make
```

or

```bash
make all
```

---

## Stop Infrastructure

```bash
make down
```

---

## Rebuild Infrastructure

```bash
make re
```

---

# Docker Concepts

## Docker Images

Each service is built using a custom Dockerfile.

Images are composed of layers:

- base OS layer
- package installation layer
- configuration layer
- startup layer

Docker uses:

- containerd
- runc
- overlay filesystem

to create and manage containers.

---

## Docker Containers

A container is:

- an isolated process
- lightweight runtime
- not a virtual machine
- sharing the host kernel

Each service runs inside its own dedicated container.

---

## Docker Network

Containers communicate through a Docker bridge network.

Advantages:

- isolation
- internal DNS
- secure communication
- service discovery

Forbidden:

- host network
- links
- --link

---

## Docker Volumes

Named volumes are used for persistence.

Volumes used:

- wordpress_data
- mariadb_data

Host path:

```text
/home/achemlal/data
```

Advantages:

- persistent data
- independent from containers
- safer storage
- easier backups

---

# Comparisons

## Virtual Machines vs Docker

| Virtual Machines | Docker |
|---|---|
| Full operating system | Shared kernel |
| Heavy | Lightweight |
| Slow startup | Fast startup |
| High resource usage | Low resource usage |

### Why Docker?

Docker is:

- faster
- lighter
- easier to deploy
- reproducible

---

## Secrets vs Environment Variables

| Secrets | Environment Variables |
|---|---|
| Secure | Less secure |
| Hidden from image history | Visible in process environment |
| Used for passwords | Used for configuration |

### Why Secrets?

Sensitive data should never be hardcoded.

Examples:

- database passwords
- root passwords

---

## Docker Network vs Host Network

| Docker Network | Host Network |
|---|---|
| Isolated | Shared with host |
| Secure | Less secure |
| Internal communication | No isolation |

### Why Docker Network?

Better:

- security
- separation
- scalability

---

## Docker Volumes vs Bind Mounts

| Docker Volumes | Bind Mounts |
|---|---|
| Managed by Docker | Managed by host |
| Portable | Host dependent |
| Better isolation | Direct filesystem access |

### Why Volumes?

Volumes are:

- cleaner
- safer
- recommended for persistence

---

# Security

Implemented security practices:

- HTTPS only
- TLSv1.2 / TLSv1.3
- Docker secrets
- isolated containers
- no hardcoded passwords
- internal networking

---

# Useful Commands

## Containers

```bash
docker ps
docker ps -a
docker logs <container>
docker exec -it <container> sh
```

---

## Images

```bash
docker images
```

---

## Volumes

```bash
docker volume ls
docker volume inspect <volume>
```

---

## Networks

```bash
docker network ls
docker network inspect <network>
```

---

# Resources

- https://docs.docker.com/
- https://docs.docker.com/compose/
- https://nginx.org/en/docs/
- https://mariadb.org/documentation/
- https://developer.wordpress.org/

---

# AI Usage

AI tools were used for:

- Docker architecture explanations
- documentation structure
- debugging ideas
- infrastructure understanding

All generated content was reviewed and understood before usage.

---

# Author

- achemlal