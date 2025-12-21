
FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y \
    openssl \
    nginx

RUN mkdir -p /etc/nginx/ssl/key /etc/nginx/ssl/certs

RUN openssl req -x509 -nodes -days 90 -newkey rsa:2048 \
    -subj "/C=MA/ST=KH/OU=1337/CN=moait-la.42.fr" \
    -keyout /etc/nginx/ssl/key/key.key \
    -out /etc/nginx/ssl/certs/cert.crt

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
