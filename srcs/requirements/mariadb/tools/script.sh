
#!/bin/bash

service mariadb start

while ! mysqladmin ping --silent; do 
    sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME};"
mysql -e "CREATE USER IF NOT EXISTS '${WP_DB_USER_NAME}'@'%' IDENTIFIED BY '${WP_DB_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_USER_NAME}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

service mariadb stop

while mysqladmin ping --silent; do
    sleep 1
done

exec mysqld_safe
