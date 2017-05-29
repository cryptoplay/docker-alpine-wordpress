FROM cryptoplay/alpine:3.6
MAINTAINER CryptoPlay <docker@cryptoplay.tk>

ARG BUILD_DATE
ARG CI_BUILD_URL
ARG VCS_REF
ARG VERSION

LABEL   io.github.cryptoplay.build-date=$BUILD_DATE \
        io.github.cryptoplay.ci-build-url=$CI_BUILD_URL \
        io.github.cryptoplay.url="https://cryptoplay.github.io/" \
        io.github.cryptoplay.docker.dockerfile="/Dockerfile" \
        io.github.cryptoplay.license="Apache License 2.0" \
        io.github.cryptoplay.vcs-ref=$VCS_REF \
        io.github.cryptoplay.vcs-type="Git" \
        io.github.cryptoplay.vcs-url="https://github.com/cryptoplay/docker-alpine-wordpress.git" \
        io.github.cryptoplay.vendor="cryptoplay" \
        io.github.cryptoplay.version=$VERSION
        io.github.cryptoplay.type="site" \
        io.github.cryptoplay.cms="wordpress" \
        io.github.cryptoplay.framework="wordpress" \
        io.github.cryptoplay.language="php7" \
        io.github.cryptoplay.require="mariadb cryptoplay/alpine-nginx-proxy" \
        io.github.cryptoplay.recommend="redis" \
        io.github.cryptoplay.description="WordPress on Nginx and PHP-FPM with WP-CLI running in Docker Alpine Container." \
        io.github.cryptoplay.name="WordPress" \
        io.github.cryptoplay.params="docker run -d --name {container_name} -e VIRTUAL_HOST={virtual_hosts} -v /data/sites/{domain_name}:/DATA cryptoplay/alpine-wordpress"


RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories\
    && apk update \
    && apk add --no-cache \
    bash \
    less \
    vim \
    nano \
    nginx \
    ca-certificates \
    php7-fpm \
    php7-json \
    php7-zlib \
    php7-xml \
    php7-pdo \
    php7-phar \
    php7-openssl \
    php7-pdo_mysql \
    php7-mysqli \
    php7-session \
    php7-gd \
    php7-iconv \
    php7-mcrypt \
    php7-curl \
    php7-opcache \
    php7-ctype \
    php7-apcu \
    php7-intl \
    php7-bcmath \
    php7-mbstring \
    php7-dom \
    php7-xmlreader \
    mysql-client \
    openssh-client \
    git \
    curl \
    rsync \
    musl \
    && apk --update --no-cache add tar
RUN rm -rf /var/cache/apk/*

ENV TERM="xterm" \
    DB_HOST="172.17.0.1" \
    DB_NAME="" \
    DB_USER=""\
    DB_PASS=""


ENV PATH /DATA/bin:$PATH

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php7/php.ini && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/DATA:\/bin\/bash/g" /etc/passwd && \
    sed -i "s/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/DATA:\/bin\/bash/g" /etc/passwd-


ADD src/nginx.conf /etc/nginx/
ADD src/php-fpm.conf /etc/php7/
ADD src/run.sh /
RUN chmod +x /run.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp-cli && chown nginx:nginx /usr/bin/wp-cli

EXPOSE 80
VOLUME ["/DATA"]

CMD ["/run.sh"]
