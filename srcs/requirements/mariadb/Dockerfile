
FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y mariadb-server

COPY ./tools/script.sh .

RUN chmod +x ./script.sh

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

ENTRYPOINT ["/bin/bash", "./script.sh"]
