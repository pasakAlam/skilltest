FROM alpine:3.18

# Enable repo community
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk update 
RUN apk upgrade musl
RUN apk add --no-cache  \
    php81 \
    php81-openssl \
    php81-pdo_mysql \
    php81-mbstring \
    php81-fpm \
    php81-mysqli \
    php81-opcache \
    php81-json \
    php81-session \
    nginx \
    supervisor

# Add directory 
RUN adduser -S www-data -G www-data
RUN mkdir -p /run/nginx /var/www/html
RUN chown -R www-data:www-data /var/www/html


# Copy Configuration and Files
COPY ./nginx/default.conf /etc/nginx/http.d/default.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./src/index.php /var/www/html/index.php
COPY ./php/www.conf /etc/php81/php-fpm.d/www.conf

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]