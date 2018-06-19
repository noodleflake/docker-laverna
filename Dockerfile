FROM alpine:latest
RUN apk update \
        && apk add unzip lighttpd sed openssl \
        && rm -f -r /var/www/*
WORKDIR /var/www
RUN wget https://github.com/Laverna/static-laverna/archive/gh-pages.zip -O /var/www/laverna.zip \
        && unzip laverna.zip -d /var/www/ \
        && rm laverna.zip \
        && mv `ls` laverna \
	&& cp /etc/ssl/openssl.cnf openssl.cnf \
        && echo '[ subject_alt_name ]' >> openssl.cnf \
	&& echo 'subjectAltName = DNS:*, DNS:*.*, DNS:*.*.*, DNS:*.*.*.*' >> openssl.cnf \
	&& openssl req -newkey rsa:2048 -config openssl.cnf -nodes -keyout lighttpd.key -x509 -days 1095 -out lighttpd.crt \
	   -subj '/C=ZA/ST=WC/L=STAR/O=laverna-docker/OU=laverna-docker/CN=localhost/emailAddress=none@none.com' \
	&& mkdir /etc/lighttpd/ssl \
	&& cat lighttpd.key lighttpd.crt > /etc/lighttpd/ssl/lighttpd.pem \
	&& rm lighttpd.key lighttpd.crt
LABEL maintainer="martinswanepoel88@gmail.com"

ENV LIGHTTPD_SSL_PEMFILE="" \
 LIGHTTPD_SSL_CAFILE=""

WORKDIR /tmp/workdir
COPY assets assets
COPY build.sh build.sh

RUN ./build.sh && rm -f build.sh

EXPOSE 6080
EXPOSE 6443

VOLUME /etc/lighttpd/ssl

USER lighttpd

ENTRYPOINT ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
