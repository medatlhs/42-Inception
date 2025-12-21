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
- All containers communicate through a custom Docker network and are configured to restart automatically in case of failure.

#### Starting and Stopping the Project

All interactions with the project are done exclusively through the Makefile.
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

4. Credentials Management
Environment variables

Non-sensitive configuration values are stored in:

srcs/.env


This file contains values such as:

Domain name

Database name

Database user

Secrets

Sensitive information is never stored in Dockerfiles or committed to Git.

Passwords and credentials are stored as Docker secrets in the secrets/ directory:

secrets/
├── credentials.txt
├── db_password.txt
└── db_root_password.txt


These files are:

Loaded securely into the containers

Ignored by Git

Used during container initialization

To update credentials, modify the corresponding secret file and restart the project.

5. Checking That Services Are Running
Check container status
make ps


All services should appear as running.

View logs

To inspect logs for all services:

make logs


This helps verify correct startup or diagnose errors.

6. Data Persistence

Project data is stored on the host machine at:

/home/<login>/data/


WordPress files persist even if containers are rebuilt

Database data remains intact when containers are stopped or restarted

7. Expected Behavior

When the project is working correctly:

Only NGINX is exposed to the outside (port 443)

WordPress and MariaDB are accessible only through the Docker network

Containers restart automatically on failure

No credentials are hardcoded in images or source files

The website loads correctly over HTTPS

If all these conditions are met, the infrastructure is considered functional and correctly configured.
