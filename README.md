*This project has been created as part of the 42 curriculum by moait-la.*

# Inception

## Description

**Inception** is a system administration and DevOps project that aims to introduce containerization using **Docker** and **Docker Compose**.

The goal of the project is to build a small, secure, and isolated infrastructure composed of multiple services running in separate Docker containers, all orchestrated using Docker Compose and executed inside a virtual machine.

This infrastructure includes:
- An **NGINX** web server secured with **TLSv1.2 / TLSv1.3**
- A **WordPress** application running with **PHP-FPM**
- A **MariaDB** database
- Persistent **Docker volumes** for database and website data
- A dedicated **Docker network** for internal communication

All services are built **from scratch using custom Dockerfiles**, without relying on prebuilt images except Debian base images, and follow Docker best practices.

---

## Project Architecture

The infrastructure is composed of the following services:

- **NGINX**
  - Acts as the only public entry point
  - Listens on port **443**
  - Handles HTTPS using TLSv1.2 or TLSv1.3
  - Proxies requests to WordPress

- **WordPress**
  - Runs with PHP-FPM only (no NGINX)
  - Connects to MariaDB using environment variables
  - Website files are stored in a persistent volume

- **MariaDB**
  - Runs independently without NGINX
  - Stores WordPress database data in a persistent volume
  - Uses secure credentials via environment variables and Docker secrets

- **Docker Network**
  - Allows containers to communicate internally
  - No use of `--link`, `links`, or `network: host`

- **Docker Volumes**
  - One volume for WordPress database
  - One volume for WordPress website files
  - Stored on the host at `/home/moait-la/data`

---

## Instructions

### Prerequisites

- Linux virtual machine
- Docker
- Docker Compose
- Make

### Setup

1. Clone the repository :
   ```bash
   git clone repository_url
   cd inception
2. Configure .env inside /srcs :
  The project is configured using a `.env` file located in `srcs/`.
  Values are **not included** for security reasons.
```env
  # MariaDB
  WP_DB_NAME=
  WP_DB_USER_NAME=
  WP_DB_PASSWORD=
  WP_DB_HOST=

  # WordPress
  WP_URL=
  WP_TITLE=

  # WordPress admin
  WP_ADMIN=
  WP_ADMIN_PASS=
  WP_ADMIN_EMAIL=

  # WordPress user
  WP_USR=
  WP_USR_EMAIL=
  WP_USR_ROLE=
  WP_USR_PASS=
```
4. Configure local DNS :
   ```bash
   sudo vim /etc/hosts
   127.0.0.1 maoit-la.42.fr

### Build And Run
This project is fully managed using Makefile
```bash
make 
make up        # Start containers
make down      # Stop containers
make clean     # Remove containers
make fclean    # Remove containers, images, and volumes
make re        # Rebuild everything

