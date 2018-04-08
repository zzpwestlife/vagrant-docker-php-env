FROM php:5.6-fpm

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.163.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

# Install modules
RUN apt-get update
RUN apt-get install -y \
        git \
        curl \
        openssl \
        wget \
        vim \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libicu-dev \
             --no-install-recommends

#install extension
RUN docker-php-ext-install zip \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install bcmath

#install gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

#install swoole
RUN wget https://github.com/swoole/swoole-src/archive/v2.0.12.tar.gz -O swoole.tar.gz \
    && mkdir -p swoole \
    && tar -xf swoole.tar.gz -C swoole --strip-components=1 \
    && rm swoole.tar.gz \
    && ( \
        cd swoole \
        && phpize \
        && ./configure \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r swoole \
    && docker-php-ext-enable swoole

#install libmemcached
RUN wget http://pecl.php.net/get/memcache-3.0.8.tgz \
    && pecl install memcache-3.0.8.tgz \
    && rm -f memcache-3.0.8.tgz \
    && docker-php-ext-enable memcache

# Install composer && global asset plugin
ENV COMPOSER_HOME /root/.composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com

#RUN apt-get purge -y g++ \
#    && apt-get autoremove -y \
#    && rm -r /var/lib/apt/lists/* \
#    && rm -rf /tmp/*

RUN usermod -u 1000 www-data

EXPOSE 9000
CMD ["php-fpm"]