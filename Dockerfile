FROM wordpress:beta-php8.4-fpm-alpine

# Устанавливаем зависимости и WP-CLI
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    libzip-dev \
    openssl-dev \
    curl \
    less \
    bash \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del $PHPIZE_DEPS \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
