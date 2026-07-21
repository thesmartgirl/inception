# Developer Documentation

# Project Overview

The infrastructure consists of three Docker containers connected through a private bridge network.

```
NGINX
   │
PHP-FPM
   │
WordPress
   │
MariaDB
```

Persistent data is stored in Docker named volumes, while credentials are provided through Docker secrets.

---

# Prerequisites

Install:

* Docker
* Docker Compose
* GNU Make

---

# Repository Structure

```
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
├── secrets/
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── mariadb/
        ├── nginx/
        └── wordpress/
```

---

# Configuration

## Environment Variables

Edit:

```
srcs/.env
```

Typical values include:

* DOMAIN_NAME
* MYSQL_DATABASE
* MYSQL_USER
* WP_ADMIN_USER
* WP_ADMIN_EMAIL
* WP_USER
* WP_USER_EMAIL

Passwords are intentionally excluded from this file.

---

## Secrets

Create the following files:

```
secrets/
├── db_password.txt
├── db_root_password.txt
├── wp_admin_password.txt
└── wp_user_password.txt
```

Each file should contain only the corresponding password.

---

# Building the Project

Build images:

```bash
make build
```

or

```bash
docker compose -f srcs/docker-compose.yml build
```

---

# Starting the Project

```bash
make
```

or

```bash
make up
```

---

# Stopping the Project

```bash
make down
```

---

# Rebuilding

```bash
make re
```

---

# Managing Containers

List running containers:

```bash
make ps
```

Open a shell:

```bash
make exec-nginx
make exec-wordpress
make exec-mariadb
```

View logs:

```bash
make logs
```

---

# Managing Volumes

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect wp_website_data
```

Remove unused volumes:

```bash
docker volume prune
```

---

# Persistent Data

The project uses two Docker named volumes:

* `mariadb_data`
* `wp_website_data`

These volumes are configured to store their contents under:

```
/home/ataan/data/
```

on the host machine, satisfying the project requirements.

Data remains available even if containers are removed and recreated.

This is configured at 
```
/etc/docker/daemon.json
```
