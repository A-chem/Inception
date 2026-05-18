# DEVELOPER DOCUMENTATION

# Overview

This document explains how developers can:

- configure the environment
- build containers
- manage Docker services
- understand persistence
- debug the infrastructure

---

# Prerequisites

Required:

- Docker
- Docker Compose
- Make
- Linux virtual machine

Recommended systems:

- Debian
- Ubuntu

---

# Install Docker

## Debian / Ubuntu

```bash
sudo apt update
sudo apt install docker.io docker-compose make
```

Enable Docker service:

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

Verify installation:

```bash
docker --version
docker compose version
```

---

# Project Structure

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

# Environment Configuration

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

# Secrets Configuration

Create:

```text
secrets/
├── db_password.txt
├── db_root_password.txt
└── credentials.txt
```

Purpose:

| Secret File | Description |
|---|---|
| db_password.txt | WordPress database password |
| db_root_password.txt | MariaDB root password |
| credentials.txt | Additional credentials |

Important:

- never hardcode passwords
- never push secrets to GitHub

---

# Build Infrastructure

Run:

```bash
make
```

Equivalent command:

```bash
docker compose -f srcs/docker-compose.yml up --build
```

This process:

- builds Docker images
- creates containers
- creates volumes
- creates network
- starts infrastructure

---

# Stop Infrastructure

```bash
make down
```

Equivalent:

```bash
docker compose -f srcs/docker-compose.yml down
```

---

# Rebuild Infrastructure

```bash
make re
```

This command:

- removes containers
- rebuilds images
- recreates infrastructure

---

# Docker Compose Responsibilities

Docker Compose manages:

- image building
- container creation
- network creation
- volume mounting
- environment variables
- secrets injection

---

# Dockerfiles

Each service has its own Dockerfile.

Example:

```text
requirements/nginx/Dockerfile
requirements/mariadb/Dockerfile
requirements/wordpress/Dockerfile
```

Each Dockerfile contains:

- base image
- package installation
- configuration
- startup commands

---

# Container Lifecycle

## Build Phase

Docker:

1. reads Dockerfile
2. creates layers
3. builds image

---

## Runtime Phase

Docker:

1. creates writable layer
2. starts container process
3. mounts volumes
4. connects network
5. runs entrypoint

---

# PID 1

Inside a container, the main process becomes PID 1.

Responsibilities:

- signal handling
- process lifecycle
- container shutdown

Forbidden bad practices:

```bash
tail -f
sleep infinity
while true
```

Containers should run real services instead of fake infinite loops.

---

# Docker Networking

Containers communicate using a Docker bridge network.

Example:

```yaml
networks:
  inception:
```

Benefits:

- isolation
- internal DNS
- secure communication
- service discovery

Forbidden:

- host network
- links
- --link

---

# Persistent Data

## Docker Volumes

Used volumes:

- wordpress_data
- mariadb_data

List volumes:

```bash
docker volume ls
```

Inspect volume:

```bash
docker volume inspect wordpress_data
```

---

# Host Storage

Volumes store data inside:

```text
/home/achemlal/data
```

Persistence guarantees:

- data survives container restart
- data survives image rebuild
- database remains available

---

# Useful Docker Commands

## Containers

```bash
docker ps
docker ps -a
docker restart <container>
docker stop <container>
```

---

## Images

```bash
docker images
docker rmi <image>
```

---

## Logs

```bash
docker logs <container>
```

Follow logs:

```bash
docker logs -f <container>
```

---

# Debugging

## Enter Container

```bash
docker exec -it <container> sh
```

Example:

```bash
docker exec -it nginx sh
```

---

## Inspect Network

```bash
docker network inspect inception
```

---

## Inspect Volumes

```bash
docker volume inspect mariadb_data
```

---

# Common Issues

## Containers Restarting

Possible causes:

- bad entrypoint
- service crash
- invalid configuration
- missing permissions

Check logs:

```bash
docker logs <container>
```

---

## NGINX Cannot Connect to WordPress

Verify:

- Docker network exists
- php-fpm is running
- service names are correct
- FastCGI configuration is valid

---

## MariaDB Initialization Failure

Check:

- mounted volumes
- permissions
- secrets paths
- environment variables

---

# Security Practices

Implemented security:

- TLSv1.2 / TLSv1.3
- Docker secrets
- isolated containers
- no hardcoded passwords

Avoid:

- latest tag
- host networking
- public credentials

---

# Development Workflow

Typical workflow:

```bash
make
docker ps
docker logs nginx
docker exec -it wordpress sh
```

---

# Cleaning Environment

Remove containers:

```bash
docker compose down
```

Remove images:

```bash
docker image prune -a
```

Remove volumes:

```bash
docker volume prune
```

---

# Additional Notes

The infrastructure follows Docker best practices:

- isolated services
- persistent storage
- secure networking
- custom Docker images
- TLS encryption

All services are built using custom Dockerfiles.