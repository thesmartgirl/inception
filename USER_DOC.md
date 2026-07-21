# User Documentation

# Overview

This project deploys a simple web infrastructure composed of three services:

* **NGINX** – serves as the public web server and HTTPS reverse proxy.
* **WordPress** – provides the website and administration interface.
* **MariaDB** – stores the WordPress database.

Only the NGINX service is accessible from outside the Docker network.

---

# Starting the Project

To build and start all services:

```bash
make
```

or

```bash
make up
```

The first startup may take a few minutes while Docker images are built and WordPress initializes.

---

# Stopping the Project

To stop the containers:

```bash
make down
```

To stop the project and remove containers, networks and volumes:

```bash
make clean
```

---

# Accessing the Website

Open your browser and visit:

```
https://ataan.42.fr
```

Since the project uses a self-signed TLS certificate, your browser will display a security warning on the first visit. This is expected during development.

---

# Accessing the WordPress Administration Panel

Open:

```
https://ataan.42.fr/wp-admin
```

Log in using the administrator credentials configured during installation.

---

# Credentials

Passwords are **not stored inside the Docker images**.

Sensitive credentials are stored in the project's `secrets/` directory.

Typical files include:

```
secrets/
├── db_password.txt
├── db_root_password.txt
├── wp_admin_password.txt
└── wp_user_password.txt
```

Other configuration values (database name, usernames, domain name, email addresses, etc.) are stored in:

```
srcs/.env
```

---

# Checking Service Status

List running containers:

```bash
docker ps
```

Expected containers:

* nginx
* wordpress
* mariadb

---

# Viewing Logs
ALL:

```bash
make logs
```

NGINX:

```bash
docker logs nginx
```

WordPress:

```bash
docker logs wordpress
```

MariaDB:

```bash
docker logs mariadb
```

---

# Checking Website Availability

Verify that the website responds over HTTPS:

```bash
curl -k https://ataan.42.fr
```

The `-k` option ignores the self-signed certificate warning.

---

# Troubleshooting

If the website is unavailable:

1. Verify all containers are running.
2. Check each container's logs.
3. Verify that Docker volumes exist.
4. Confirm the secrets and `.env` file contain valid values.
5. Restart the project:

```bash
make re
```
