FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG WEBTREES_VERSION=2.1.12

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2 \
        # ca-certificates to dl from github
        ca-certificates \
        php8.1 \
        php8.1-curl \
        php8.1-gd \
        php8.1-intl \
        php8.1-mbstring \
        php8.1-mysql \
        php8.1-xml \
        php8.1-zip \
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

COPY ./assets/ /app/

RUN chmod +x /app/entrypoint.sh
