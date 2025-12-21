
FROM debian:bookworm 

RUN apt-get update && \
    apt-get install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    curl

RUN curl -O \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/script.sh .

RUN chmod +x ./script.sh

ENTRYPOINT [ "bash", "./script.sh" ]



