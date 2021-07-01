#!/bin/sh

PACKAGES="
php7.3-cli
php7.3-common
php7.3-curl
php7.3-gd
php7.3-intl
php7.3-json
php7.3-mbstring
php7.3-mysql
php7.3-opcache
php7.3-readline
php7.3-sqlite3
php7.3-xml
php7.3-zip
php-xdebug
pkg-config
autoconf
libsqlite3-dev
libssl-dev
libxml2-dev
zlib1g-dev
libbz2-dev
libcurl4-openssl-dev
libjpeg-dev
libpng-dev
libreadline-dev
libtidy-dev
libmcrypt-dev
libonig-dev
libxslt-dev
libzip-dev
"

sudo apt-get update
sudo apt-get -y install $PACKAGES
