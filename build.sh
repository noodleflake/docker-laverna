#!/bin/sh

set -ex

cp -r -p assets/* /
rm -rf assets

## workaround for bug preventing sync between VirtualBox and host
# http://serverfault.com/questions/240038/lighttpd-broken-when-serving-from-virtualbox-shared-folder
echo server.network-backend = \"writev\" >> /etc/lighttpd/lighttpd.conf

chmod a+x /etc/lighttpd/optional.sh

mkdir -p /etc/lighttpd/ssl
mkdir -p /etc/lighttpd/users
chown -R root:root /etc/lighttpd

chown lighttpd:lighttpd /run

rm -rf /tmp/*
rm -rf /var/tmp/*
