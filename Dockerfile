FROM wordpress:beta-php8.4-fpm-alpine

# Установка зависимостей и WP-CLI
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    libzip-dev \
    openssl-dev \
    curl \
    less \
    bash \
    su-exec \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del $PHPIZE_DEPS \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Установка supercronic
RUN curl -L https://github.com/aptible/supercronic/releases/latest/download/supercronic-linux-amd64 -o /usr/local/bin/supercronic \
    && chmod +x /usr/local/bin/supercronic

# Создание cron-файла
RUN echo "*/5 * * * * su-exec www-data wp cron event run --path=/var/www/html" > /etc/wp-cron.cron

# Запуск php-fpm и supercronic
CMD ["/bin/sh", "-c", "php-fpm & supercronic /etc/wp-cron.cron"]
