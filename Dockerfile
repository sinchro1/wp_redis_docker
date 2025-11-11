FROM wordpress:beta-php8.4-fpm-alpine

# Устанавливаем зависимости для сборки PECL-расширений
RUN apk add --no-cache \
    $PHPIZE_DEPS \
    libzip-dev \
    openssl-dev \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del $PHPIZE_DEPS
