# *This project has been created as part of the 42 curriculum by ataan.*

# Inception

## Description

Inception is a system administration project from the 42 curriculum that introduces containerization using Docker. The objective is to build a complete web infrastructure composed of multiple isolated services communicating over a private Docker network.

The infrastructure consists of three containers:

- **NGINX** acting as the only public entry point using HTTPS.
- **WordPress** running with PHP-FPM.
- **MariaDB** providing persistent database storage.

Each service is built from its own Dockerfile based on Alpine Linux and communicates only through Docker networking. Persistent application data is stored using Docker named volumes, while sensitive credentials are managed through Docker secrets.

---

# Architecture

```
                Internet
                    │
              HTTPS (443)
                    │
               +-----------+
               |   NGINX   |
               +-----------+
                     │
             FastCGI │
                     ▼
               +-----------+
               | WordPress |
               | PHP-FPM   |
               +-----------+
                     │
                 MariaDB
                     ▼
               +-----------+
               | MariaDB   |
               +-----------+
```

---

# Project Structure

```
.
├── Makefile
├── README.md
├── secrets/
├── srcs/
│   ├── docker-compose.yml
│   ├── .env
│   └── requirements/
│       ├── mariadb/
│       ├── nginx/
│       └── wordpress/
```

---

# Technologies

- Docker
- Docker Compose
- Alpine Linux
- NGINX
- MariaDB
- WordPress
- PHP-FPM
- OpenSSL

---

# Design Choices

### Docker

Each service runs inside its own container.

This follows Docker's philosophy of **one service per container**, making the infrastructure modular, isolated and easy to maintain.

---

### Networking

Containers communicate through a dedicated Docker bridge network.

Only the NGINX container exposes a port to the host machine.

---

### Storage

Persistent data is stored using Docker named volumes.

The volumes are configured to store their data under:

```
/home/ataan/data
```

on the host machine, as required by the project subject.

---

### Security

Sensitive information such as database and WordPress passwords is stored using Docker secrets rather than inside the Docker images.

The website is served exclusively over HTTPS using a self-signed TLS certificate.

---

# Comparison of Concepts

## Virtual Machines vs Docker

| Virtual Machine | Docker |
|-----------------|---------|
| Virtualizes an entire operating system | Virtualizes applications |
| Includes its own kernel | Shares the host kernel |
| Large disk usage | Lightweight |
| Slower startup | Starts in seconds |
| Higher resource consumption | Efficient resource usage |

Docker containers provide process isolation while remaining much lighter than virtual machines.

---

## Docker Secrets vs Environment Variables

### Environment Variables

- Easy to configure
- Visible inside the container
- Can accidentally appear in logs
- Appropriate for non-sensitive configuration

### Docker Secrets

- Intended for passwords and credentials
- Stored separately from the image
- Mounted as read-only files inside the container
- Better suited for sensitive information

For this project, passwords are stored as Docker secrets while general configuration remains inside the `.env` file.

---

## Docker Network vs Host Network

### Host Network

Containers share the host network directly.

Advantages:

- No network translation
- Maximum performance

Disadvantages:

- Reduced isolation
- Higher security risk
- Possible port conflicts

### Docker Bridge Network

Containers communicate through an isolated virtual network.

Advantages:

- Better isolation
- Internal DNS resolution
- Containers communicate using service names

This project uses a dedicated Docker bridge network.

---

## Docker Volumes vs Bind Mounts

### Bind Mount

Maps an existing host directory directly into a container.

Pros:

- Easy development
- Immediate file synchronization

Cons:

- Depends on host filesystem layout
- Less portable

---

### Docker Named Volume

Managed directly by Docker.

Pros:

- Portable
- Independent from host filesystem
- Preferred for persistent application data

This project uses Docker named volumes stored under:

```
/home/ataan/data
```

as required by the subject.

---

# Instructions

## Requirements

- Docker
- Docker Compose
- GNU Make

---

## Clone

```bash
git clone <repository_url>
cd inception
```

---

## Create secrets

Create the following files:

```
secrets/
├── db_password.txt
├── db_root_password.txt
├── wp_admin_password.txt
└── wp_user_password.txt
```

Each file should contain a single password.

---

## Configure

Edit:

```
srcs/.env
```

and provide the required configuration values.

---

## Build and start

```bash
make
```

or

```bash
make up
```

---

## Stop

```bash
make down
```

---

## Rebuild

```bash
make re
```

---

## Access

Open:

```
https://ataan.42.fr
```

---

# Resources

## Docker

- https://docs.docker.com/

## Docker Compose

- https://docs.docker.com/compose/

## NGINX

- https://nginx.org/en/docs/

## MariaDB

- https://mariadb.com/kb/

## WordPress

- https://developer.wordpress.org/

## PHP-FPM

- https://www.php.net/manual/en/install.fpm.php

## OpenSSL

- https://www.openssl.org/docs/

---

# AI Usage

AI assistance (ChatGPT) was used during this project for:

- Understanding Docker concepts
- Explaining networking and containerization
- Learning NGINX configuration
- Understanding TLS certificates
- Debugging Docker configuration issues
- Reviewing Dockerfiles and shell scripts
- Explaining Docker volumes, secrets and networking
- Producing documentation

All implementation decisions, debugging, testing and final code integration were performed manually.
