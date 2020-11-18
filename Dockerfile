FROM php:7.4.12-fpm
LABEL version="1.0.0"

RUN apt-get -y update --fix-missing
RUN apt-get upgrade -y
RUN apt-get -y install --fix-missing apt-utils build-essential \
                        curl openssl libcurl4-openssl-dev pkg-config \
                        libssl-dev zip unzip git libxml2 zlib1g-dev libxml2-dev \
                        libzip-dev libpng-dev libjpeg-dev libxrender-dev libsodium-dev\
                        libfontconfig libc-client-dev libkrb5-dev && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mysqli bcmath soap zip gd imap sodium
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure gd --with-jpeg

RUN pecl uninstall mongodb && pecl install mongodb && docker-php-ext-enable mongodb 
RUN pecl uninstall protobuf && pecl install protobuf && docker-php-ext-enable protobuf 
RUN pecl uninstall grpc && pecl install grpc && docker-php-ext-enable grpc 
