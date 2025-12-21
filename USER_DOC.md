User Documentation

This document explains how to use the Inception project as an end user or system administrator.
It covers the provided services, how to run the project, how to access WordPress, where credentials are stored, and how to verify that everything is working correctly.

1. Services Overview

This project sets up a small web infrastructure using Docker Compose.
The stack provides the following services:

NGINX

Acts as the single entry point to the infrastructure

Listens only on port 443

Uses TLSv1.2 / TLSv1.3 for secure HTTPS connections

Forwards requests to WordPress

WordPress (PHP-FPM)

Hosts the WordPress website

Runs with PHP-FPM only (no NGINX inside the container)

Stores website files in a dedicated Docker volume

MariaDB

Stores the WordPress database

Runs in its own container without any web server

Database data is persisted in a Docker volume

All services communicate through a custom Docker network and restart automatically in case of a crash.

2. Starting and Stopping the Project
Start the infrastructure

From the root of the repository, run:

make up


This command:

Builds all Docker images

Creates the required network and volumes

Starts all containers

Stop the infrastructure

To stop the running containers:

make down


This stops the services without deleting volumes.

Full cleanup (optional)

To stop everything and remove containers, images, and volumes:

make fclean

3. Accessing the Website and Admin Panel
Website access

Once the project is running, the website is available at:

https://<login>.42.fr


Example:

https://wil.42.fr


Your domain name must be configured to point to your local machine’s IP address.

WordPress administration panel

The WordPress admin dashboard can be accessed at:

https://<login>.42.fr/wp-admin


Use the administrator credentials defined during setup.

4. Credentials Management
Environment variables

Non-sensitive configuration values are stored in:

srcs/.env


Examples:

Domain name

Database user

Database name

Secrets

Sensitive data is not stored in Dockerfiles or in Git.
Passwords and credentials are stored as Docker secrets in the secrets/ directory:

secrets/
├── credentials.txt
├── db_password.txt
└── db_root_password.txt


These files are:

Loaded securely into the containers

Ignored by Git

Used by MariaDB and WordPress during initialization

To change a password, update the corresponding secret file and restart the containers.

5. Checking Service Status
Check running containers
docker ps


You should see containers for:

nginx

wordpress

mariadb

Check container logs

To inspect logs for a specific service:

docker logs <container_name>


Example:

docker logs nginx

Check Docker Compose status
docker compose ps


This shows whether all services are running correctly.

6. Data Persistence

Project data is stored in Docker volumes located on the host machine at:

/home/<login>/data/


WordPress files persist even if containers are rebuilt

Database data is not lost when containers stop or restart

7. Expected Behavior

Only NGINX is exposed to the outside (port 443)

WordPress and MariaDB are accessible only through the Docker network

Containers restart automatically on failure

No credentials are hardcoded in images or source files

If the website loads correctly over HTTPS and all containers are running, the infrastructure is working as expected.
