## Developer Documentation

This document is intended for developers who want to understand, set up, and work on the Inception project.
It explains how to prepare the environment from scratch, how the project is built and launched, how to manage containers and volumes, and how data persistence is handled.

### Prerequisites
Before starting, ensure the following tools are installed on the host machine:
- Docker
- Docker Compose
- Make
- A Linux-based system (project is designed to run inside a virtual machine)
The project must be run inside a virtual machine, as required by the subject.

### Project Structure Overview

The repository is organized as follows
```text
.
├── Makefile
├── USER_DOC.md
├── DEV_DOC.md
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── mariadb/
        │   ├── conf/
        │   ├── tools/
        │   ├── Dockerfile
        ├── nginx/
        │   ├── conf/
        │   ├── Dockerfile
        ├── wordpress/
        │   ├── tools/
        │   ├── Dockerfile
```

Each service has
- Its own directory
- Its own Dockerfile
- Its own configuration and tools

### 3. Environment Setup From Scratch
#### 3.1 Domain configuration
The domain name must point to the local machines IP address. <br>
Add the following line to /etc/hosts: <br>

<local_ip> <login>.42.fr <br>

Example: <br>

127.0.0.1 moait-la.42.fr <br>
#### 3.2 Environment variables

non sensitive configuration values are stored in:
```bash
secs/.env
```
this file contains variables such as:
- DOMAIN_NAME
- Database name
- Database user

This file must exist before launching the project.

#### 3.3 Secrets configuration
Sensitive information is stored as Docker secrets inside the secrets/ directory:

```text
secrets/
├── credentials.txt
├── db_password.txt
└── db_root_password.txt
```
these files contain:

- WordPress credentials
- Database user password
- Database root password

They are:
- Not committed to Git
- Mounted securely into containers
- Used during service initialization

### 4. Building and Launching the Project
```note
This step is already mentioned in USER_DOC.md and REAME.md
```

### 5. Data Storage and Persistence

Project data is persisted using Docker volumes located on the host machine at:
```bash
/home/moait-la/data/
```
WordPress website files

MariaDB database data

#### Persistence behavior
Data is preserved when containers stop or restart <br>
Data is lost only if volumes are explicitly removed with make fclean

### 6. Design Notes

- Each service runs in a dedicated container
- Containers communicate through a custom Docker network
- Only NGINX is exposed to the host (port 443)
- WordPress and MariaDB are isolated from direct external access
- No credentials are hardcoded in Dockerfiles or source code

### 7. Development Workflow Summary
Typical workflow for a developer:
```bash
make up     # Build and start the project
make ps     # Check container status
make logs   # Inspect logs if needed
make down   # Stop the project
```



