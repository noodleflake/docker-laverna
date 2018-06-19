# Laverna Docker image

[Laverna](https://laverna.cc/) - Markdown note taking app focused on privacy.

The environment variables have the following defaults:

|Variable                 | Default                                          |
|-------------------------|--------------------------------------------------|
|LIGHTTPD_SERVER_ADDRESS  | ""                                               |
|LIGHTTPD_SERVER_PORT     | 6080                                             |
|LIGHTTPD_SSL_ADDRESS     | ""                                               |
|LIGHTTPD_SSL_PORT        | 6443                                             |
|LIGHTTPD_SSL_PEMFILE     | ""                                               |
|LIGHTTPD_SSL_CAFILE      | ""                                               |


###SSL will only work if LIGHTTPD_SSL_PEMFILE is populated, you can mount a volume containing the certs. See below HTTPS example

## Build

First clone or download the [noodleflake/docker-laverna](https://github.com/noodleflake/docker-laverna) GitHub repository, open a shell in the newly created `docker-laverna` directory, then build the image and run a container using Docker or Docker Compose, as explained below.

### Build with Docker

This command will build the image:

	$ docker build -t noodleflake/laverna .

### Run with Docker

This command will run the image:
### HTTP:

	$ docker run -d -p 80:6080 --name laverna noodleflake/laverna

### HTTPS:

	$ docker run -p 443:6443 -name laverna \
	  -e LIGHTTPD_SSL_PEMFILE="/etc/lighttpd/ssl/laverna_host_cert.pem" \
	  -e LIGHTTPD_SSL_CAFILE="/etc/lighttpd/ssl/certificate_authority.pem" \
	  -v /etc/ssl/certs:/etc/lighttpd/ssl noodleflake/laverna

## About

Written by Martin Swanepoel, released under the [MIT license](http://opensource.org/licenses/MIT).
Derived from work by [Daniel Dickinson](https://github.com/cshoredaniel/docker-lighttpd), released under the [MIT license](http://opensource.org/licenses/MIT).
