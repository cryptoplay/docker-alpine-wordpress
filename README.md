Alpine WordPress Docker Image
=======

This git repo provides the (latest) WordPress lightweight Docker image with PHP-FPM and Nginx installed
running [alpine linux](https://alpinelinux.org/) in a Docker container.

Project:            https://github.com/cryptoplay/docker-alpine-wordpress<br/>
Docker image:       https://registry.hub.docker.com/u/cryptoplay/alpine-wordpress/<br/>

[![Download size](https://images.microbadger.com/badges/image/cryptoplay/alpine-wordpress.svg)](http://microbadger.com/images/cryptoplay/alpine-wordpress "View on microbadger.com")
[![Version](https://images.microbadger.com/badges/version/cryptoplay/alpine-wordpress.svg)](http://microbadger.com/images/cryptoplay/alpine-wordpress "View on microbadger.com")
[![Source code](https://images.microbadger.com/badges/commit/cryptoplay/alpine-wordpress.svg)](http://microbadger.com/images/cryptoplay/alpine-wordpress "View on microbadger.com")
[![Docker Registry](https://img.shields.io/docker/pulls/cryptoplay/alpine-wordpress.svg)](https://registry.hub.docker.com/u/cryptoplay/alpine-wordpress)&nbsp;
[![Circle CI](https://circleci.com/gh/cryptoplay/docker-alpine-wordpress.png?circle-token=e197159ace2c041b79c52be12fc194a1a190d0f0)](https://circleci.com/gh/cryptoplay/docker-alpine-wordpress/tree/master 'View CI builds')

[![Throughput Graph](https://graphs.waffle.io/cryptoplay/docker-alpine-wordpress/throughput.svg)](https://waffle.io/cryptoplay/docker-alpine-wordpress/metrics)


How-to
------

### Image Info

* Image size only ~131MB !
* Very new packages (alpine:edge) 2016-07-21:
  * [PHP](http://pkgs.alpinelinux.org/package/main/x86/php) 7.0.13
  * [Nginx](http://pkgs.alpinelinux.org/package/main/x86/nginx) nginx/1.10.2
  * Memory usage is around 50mb on a simple install.


### A simple example

##### Say you want to run a single site on a VPS with Docker

```bash

mkdir -p /data/sites/cryptoplay.com/htdocs

sudo docker run -e VIRTUAL_HOST=cryptoplay.com,www.cryptoplay.com -v /data/sites/cryptoplay.com:/DATA -p 80:80 cryptoplay/alpine-wordpress

```
The following user and group id are used, the files should be set to this:
User ID:
Group ID:

```bash
chown -R 100:101 /data/sites/cryptoplay.com/htdocs
```

##### Say you want to run a multiple WP sites on a VPS with Docker

```bash

sudo docker run -p 80:80 --name nginx-proxy -d -v /var/run/docker.sock:/tmp/docker.sock:ro cryptoplay/alpine-nginx-proxy 
mkdir -p /data/sites/cryptoplay.tk/htdocs

sudo docker run -e VIRTUAL_HOST=cryptoplay.tk,www.cryptoplay.tk -v /data/sites/cryptoplay.tk:/DATA cryptoplay/alpine-wordpress

mkdir -p /data/sites/cryptoplay.net/htdocs
sudo docker run -e VIRTUAL_HOST=cryptoplay.net,www.cryptoplay.net -v /data/sites/cryptoplay.net:/DATA cryptoplay/alpine-wordpress
```

Populate /data/sites/cryptoplay.com/htdocs and  /data/sites/cryptoplay.net/htdocs with your WP files. See http://www.wordpressdocker.com if you need help on how to configure your database.

The following user and group id are used, the files should be set to this:
User ID:
Group ID:

```bash
chown -R 100:101 /data/sites/cryptoplay.com/htdocs
```

### Volume structure

* `htdocs`: Webroot
* `logs`: Nginx/PHP error logs


### WP-CLI

This image now includes WP-CLI wpcli.org baked in... So you can. Please `su nginx` before executing or else you can potentially compromise your host.

```
docker exec -it <container_name> bash
su nginx
cd /DATA/htdocs
wp-cli cli
```

### Multisite

For each multisite you need to give the domain as the -e VIRTUAL_HOST parameter. For instance VIRTUAL_HOST=site1.com,www.site1.com,site2.com,www.site2.com ... if you wish to add more sites you need to recreate the container.


### Upload limit

The upload limit is 2 gigabyte.


### Change php.ini value
modify files/php-fpm.conf

To modify php.ini variable, simply edit php-fpm.ini and add php_flag[variable] = value.

```
php_flag[display_errors] = on
```

Additional documentation on http://www.wordpressdocker.com


## Questions or Support

https://gitter.im/cryptoplay/cryptoplay


## Docker WordPress Control Panel

DEVOPly is a free hosting control panel which does everything taught in this tutorial automatically and much more, backups, staging/dev/prod, code editor, Github/Bitbucket deployments, DNS, WordPress Management. https://www.pluhost.com

