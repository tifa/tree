FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ARG WEBTREES_VERSION=2.0.26

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2 \
        # ca-certificates to dl from github
        ca-certificates \
        duply \
        php7.2 \
        php7.2-curl \
        php7.2-gd \
        php7.2-intl \
        php7.2-mbstring \
        php7.2-mysql \
        php7.2-xml \
        php7.2-zip \
        wget \
        unzip \
        vim \
    && rm -rf /var/lib/apt/lists/* \
    && wget --progress=dot:giga https://github.com/fisharebest/webtrees/releases/download/${WEBTREES_VERSION}/webtrees-${WEBTREES_VERSION}.zip \
    && unzip webtrees-${WEBTREES_VERSION}.zip -d /var/www \
    && rm -f webtrees-${WEBTREES_VERSION}.zip \
    && mv /var/www/webtrees/* /var/www/html/ \
    && rmdir /var/www/webtrees \
    && rm /var/www/html/index.html \
    # Webtrees recommends 777 for this folder
    && chmod 777 /var/www/html/data/

COPY ./assets/apache2/.htaccess /var/www/html/
COPY ./assets/entrypoint.sh /app/

RUN chmod +x /app/entrypoint.sh
