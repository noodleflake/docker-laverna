FROM alpine:latest
RUN apk update \
        && apk add unzip lighttpd sed \
        && rm -f -r /var/www/*
WORKDIR /var/www
RUN wget https://github.com/Laverna/static-laverna/archive/gh-pages.zip -O /var/www/laverna.zip \
        && unzip laverna.zip -d /var/www/ \
        && rm laverna.zip \
        && mv `ls` laverna
LABEL maintainer="martinswanepoel88@gmail.com"

WORKDIR /tmp/workdir
COPY assets assets
COPY build.sh build.sh

RUN ./build.sh && rm -f build.sh

EXPOSE 6080
EXPOSE 6443

VOLUME /etc/lighttpd/ssl

USER lighttpd

ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
