FROM php:7.1.28-fpm-alpine

MAINTAINER szh <sali_hub@163.com>

ENV WORK_PATH /var/www/html
ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c \
		openssl-dev

WORKDIR $WORK_PATH

ADD ./php/repo $WORK_PATH

RUN set -e \ 
&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
&& apk update && apk add $PHPIZE_DEPS \
&& docker-php-ext-install pdo_mysql \
&& tar -xf rabbitmq-c-0.8.0.tar.gz \
&& rm -rf rabbitmq-c-0.8.0.tar.gz \
&& cd rabbitmq-c-0.8.0 \ 
&& ./configure --prefix=/usr/local/rabbitmq-c-0.8.0 \ 
&& make && make install \
&& cd ../ && rm -rf rabbitmq-c-0.8.0 \
&& tar -xf amqp-1.9.4.tgz \
&& rm -rf amqp-1.9.4.tgz \
&& docker-php-ext-configure $WORK_PATH/amqp-1.9.4 --with-amqp --with-librabbitmq-dir=/usr/local/rabbitmq-c-0.8.0 \
&& docker-php-ext-install $WORK_PATH/amqp-1.9.4 \
&& rm -rf amqp-1.9.4 \
&& tar -xf redis-4.3.0.tgz \
&& rm -rf redis-4.3.0.tgz \
&& docker-php-ext-configure $WORK_PATH/redis-4.3.0 --prefix=/usr/local/redis \
&& docker-php-ext-install $WORK_PATH/redis-4.3.0 \
&& rm -rf redis-4.3.0 \
&& tar -xf msgpack-2.0.3.tgz \
&& rm -rf msgpack-2.0.3.tgz \
&& docker-php-ext-configure $WORK_PATH/msgpack-2.0.3 --prefix=/usr/local/msgpack \
&& docker-php-ext-install $WORK_PATH/msgpack-2.0.3 \
&& rm -rf msgpack-2.0.3 \
&& tar -xf yaf-3.0.8.tgz \
&& rm -rf yaf-3.0.8.tgz \
&& docker-php-ext-configure $WORK_PATH/yaf-3.0.8 --prefix=/usr/local/yaf \
&& docker-php-ext-install $WORK_PATH/yaf-3.0.8 \
&& rm -rf yaf-3.0.8 \
&& tar -xf SeasLog-2.0.2.tgz \
&& rm -rf SeasLog-2.0.2.tgz \
&& docker-php-ext-configure $WORK_PATH/SeasLog-2.0.2 --prefix=/usr/local/SeasLog \
&& docker-php-ext-install $WORK_PATH/SeasLog-2.0.2 \
&& rm -rf SeasLog-2.0.2 \
&& tar -xf xdebug-2.6.0.tgz \
&& rm -rf xdebug-2.6.0.tgz \
&& docker-php-ext-configure $WORK_PATH/xdebug-2.6.0 --prefix=/usr/local/xdebug \
&& docker-php-ext-install $WORK_PATH/xdebug-2.6.0 \
&& rm -rf xdebug-2.6.0 \
&& tar -xf scws-1.2.3.tar.bz2 \
&& rm -rf scws-1.2.3.tar.bz2 \
&& cd scws-1.2.3 && ./configure --prefix=/usr/local/scws \
&& make && make install && cd ../ \
&& docker-php-ext-configure $WORK_PATH/scws-1.2.3/phpext --with-scws=/usr/local/scws \
&& docker-php-ext-install $WORK_PATH/scws-1.2.3/phpext \
&& rm -rf scws-1.2.3 \
&& mv dict.utf8.xdb /usr/local/scws/etc/ \
&& tar -xf xhprof-2.1.0.tar.gz \
&& rm -rf xhprof-2.1.0.tar.gz \
&& docker-php-ext-configure $WORK_PATH/xhprof-2.1.0/extension --prefix=/usr/local/xhprof \
&& docker-php-ext-install $WORK_PATH/xhprof-2.1.0/extension \
&& rm -rf xhprof-2.1.0 \
&& apk del $PHPIZE_DEPS

CMD ["php-fpm"]