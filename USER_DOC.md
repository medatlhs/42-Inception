### User Documentation

This document explains how to use the Inception project as an end user or administrator.
It describes the services provided by the stack, how to start and stop the project, how to access WordPress, where credentials are stored, and how to verify that the services are running correctly.

#### Services Overview

This project deploys a small web infrastructure using Docker and Docker Compose, fully managed through a Makefile.

The stack is composed of the following services:

##### NGINX
- Acts as the only entry point to the infrastructure
- Exposes port 443 only
- Uses TLSv1.2 / TLSv1.3
- Proxies requests to the WordPress service

##### WordPress And PHP-FPM

- Hosts the WordPress website
- Runs PHP-FPM only (no NGINX inside the container)
- Website files are stored in a dedicated Docker volume

#### MariaDB

- Stores the WordPress database
- Runs in its own container without any web server
- Database data is persisted using a Docker volume

All containers communicate through a custom Docker network and are configured to restart automatically in case of failure.


## Instructions

### Prerequisites

- Linux virtual machine
- Docker
- Docker Compose
- Make

### Setup

1. Clone the repository :
   ```bash
   git clone [repo url]
   cd inception
2. Configure .env inside /srcs :<br>
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
   127.0.0.1 moait-la.42.fr

### Starting and Stopping the Project
All interactions with the project are done with the Makefile.
##### Start the infrastructure
From the root of the repository do
```bash
make up
```
This command:
- builds all Docker images
- Creates the Docker network and volumes
- Starts all services (NGINX, WordPress, MariaDB)

##### Stop the infrastructure
To stop all running containers do
```bash
make down 
```
This stops the services while keeping all data presist.

##### Full cleanup
To remove containers, images, networks, and volumes do
```bash
make fclean
```

##### Accessing the Website and Admin Panel
Once the project is running, the website is accessible at:
```bash
https://moait-la.42.fr
```
The domain name must be configured to point to the local machines IP address.<br>
The WordPress admin interface is available at:
```bash
https://moait-la.42.fr/wp-admin
```

Use the administrator credentials defined during the initial setup.

##### Checking That Services Are Running
###### Check container status
```
make status
```
All services should appear as up for sometime.

Data Persistence
Project data is stored on the host machine at:
```bash
/home/moait-la/data/
```
wordPress files persist even if containers are rebuilt
Database data remains when containers are stopped or restarted

#### Expected Behavior
When the project is working correctly:
- Only NGINX is exposed to the outside on port 443
- WordPress and MariaDB are accessible only through the Docker internal network
- Containers restart automatically on failure
- The website loads correctly over HTTPS
If all these conditions are met the infrastructure is considered functional and correctly configured
