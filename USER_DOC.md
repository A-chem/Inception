# USER DOCUMENTATION

## Overview

This infrastructure provides:

- Secure HTTPS website
- WordPress CMS
- MariaDB database
- Persistent Docker volumes

All services run inside Docker containers.

---

# Services

The stack contains:

| Service | Description |
|---|---|
| NGINX | Reverse proxy and HTTPS server |
| WordPress | Website application |
| PHP-FPM | PHP process manager |
| MariaDB | SQL database server |

---

# Starting the Project

Run:

```bash
make
```

or

```bash
make all
```

This command will:

- build Docker images
- create containers
- create Docker network
- create Docker volumes
- start all services

---

# Stopping the Project

```bash
make down
```

This command stops and removes containers.

---

# Rebuilding the Project

```bash
make re
```

This command:

- removes containers
- rebuilds images
- starts infrastructure again

---

# Accessing the Website

Open:

```text
https://achemlal.42.fr
```

Important:

- HTTPS only
- Port 443 only

---

# Accessing WordPress Admin Panel

Open:

```text
https://achemlal.42.fr/wp-admin
```

Login using administrator credentials.

---

# Credentials

Credentials are stored inside:

```text
secrets/
```

and:

```text
srcs/.env
```

Examples:

```text
db_password.txt
db_root_password.txt
credentials.txt
```

Important:

- never push secrets to GitHub
- keep passwords private

---

# Verify Running Services

Check running containers:

```bash
docker ps
```

Expected services:

- nginx
- wordpress
- mariadb

---

# Check Logs

## NGINX Logs

```bash
docker logs nginx
```

---

## WordPress Logs

```bash
docker logs wordpress
```

---

## MariaDB Logs

```bash
docker logs mariadb
```

---

# Verify HTTPS

Test HTTPS connection:

```bash
curl -k https://achemlal.42.fr
```

---

# Verify Docker Volumes

```bash
docker volume ls
```

Expected volumes:

- wordpress_data
- mariadb_data

---

# Persistent Data

Website files and database remain available after container restart because Docker volumes are used.

Data location:

```text
/home/achemlal/data
```

---

# Restart Services

Restart all services:

```bash
docker compose restart
```

Restart specific container:

```bash
docker restart nginx
```

---

# Remove Containers

```bash
docker compose down
```

---

# Common Problems

## Website Not Accessible

Check:

- containers are running
- HTTPS port is open
- domain exists in `/etc/hosts`

Example:

```text
127.0.0.1 achemlal.42.fr
```

---

## Database Connection Error

Verify:

- MariaDB container is running
- correct environment variables
- secrets are mounted correctly

---

## TLS Problems

Check:

- SSL certificates
- NGINX configuration
- HTTPS port mapping

---

# Useful Commands

## Enter Container

```bash
docker exec -it nginx sh
```

---

## Check Networks

```bash
docker network ls
```

---

## Inspect Network

```bash
docker network inspect inception
```

---

## Check Volumes

```bash
docker volume ls
```

---

## Inspect Volume

```bash
docker volume inspect wordpress_data
```