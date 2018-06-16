#!/bin/sh

echo "var.basedir = \"/var/www\""
if [ -n "$LIGHTTPD_ADDITIONAL_CONF" ]; then
	echo "include \"$LIGHTTPD_ADDITIONAL_CONF\""
fi
if [ -z "$LIGHTTPD_USERNAME" ]; then
        LIGHTTPD_USERNAME="lighttpd"
fi
if [ -z "$LIGHTTPD_GROUPNAME" ]; then
        LIGHTTPD_GROUPNAME="lighttpd"
fi
if [ -z "$LIGHTTPD_DOCROOT" ]; then
        LIGHTTPD_DOCROOT="/var/www/laverna"
fi
echo "server.username = \"$LIGHTTPD_USERNAME\""
echo "server.groupname = \"$LIGHTTPD_GROUPNAME\""
echo "server.document-root = \"$LIGHTTPD_DOCROOT\""
echo "server.bind = \"\""
echo "server.port = 6080"
echo "server.use-ipv6 = \"disable\""
if [ -n "$LIGHTTPD_MOD_1" ]; then
   echo "server.modules += ( \"$LIGHTTPD_MOD_1\" )"
fi
if [ -n "$LIGHTTPD_MOD_2" ]; then
   echo "server.modules += ( \"$LIGHTTPD_MOD_2\" )"
fi
if [ -n "$LIGHTTPD_MOD_3" ]; then
   echo "server.modules += ( \"$LIGHTTPD_MOD_3\" )"
fi
if [ -n "$LIGHTTPD_MOD_4" ]; then
   echo "server.modules +=  ( \"$LIGHTTPD_MOD_4\" )"
fi
if [ -n "$LIGHTTPD_MOD_5" ]; then
   echo "server.modules += ( \"$LIGHTTPD_MOD_5\" )"
fi
if [ "$LIGHTTPD_DIRLISTING" = "enable" ]; then
   echo dir-listing.activate      = \"enable\"
   if [ -n "$LIGHTTPD_DIRLISTING_HIDE_DOTFILES" ]; then
      echo dir-listing.hide-dotfiles = \"$LIGHTTPD_DIRLISTING_HIDE_DOTFILES\"
   fi
   if [ -n "$LIGHTTPD_DIRLISTING_FOOTER" ]; then
      echo dir-listing.set-footer    = \"$LIGHTTPD_DIRLISTING_FOOTER\"
   fi
fi
if [ -n "$LIGHTTPD_MOD_AUTH_CONF" ]; then
	echo "server.modules += ( \"mod_auth\" )"
	echo "include \"$LIGHTTPD_MOD_AUTH_CONF\""
elif [ "$LIGHTTPD_MOD_AUTH_DEFAULT" = "enable" ]; then
	echo "server.modules += ( \"mod_auth\" )"
	echo "auth.backend = \"$LIGHTTPD_AUTH_BACKEND\""
	echo "auth.backend.$LIGHTTPD_AUTH_BACKEND.userfile = \"/etc/lighttpd/users/lighttpd.users\""
	echo "auth.require = $LIGHTTPD_AUTH_REQUIRE"
fi
if [ -n "$LIGHTTPD_SSL_PEMFILE" ] && [ -r "$LIGHTTPD_SSL_PEMFILE" ]; then
	echo "\$SERVER[\"socket\"] == \":6443\" {"
	echo "server.use-ipv6 = \"disable\""
	echo "ssl.engine = \"enable\""
	echo "ssl.pemfile = \"$LIGHTTPD_SSL_PEMFILE\""
	if [ -n "$LIGHTTPD_SSL_CAFILE" ] && [ -r "$LIGHTTPD_SSL_CAFILE" ]; then
		echo "ssl.ca-file = \"$LIGHTTPD_SSL_CAFILE\""
	fi
	echo "}"
fi
if [ "$LIGHTTPD_NO_INDEX_FILES" != "enable" ]; then
	echo 'server.indexfiles    = ("index.php", "index.html",
				"index.htm", "default.htm")'
fi
