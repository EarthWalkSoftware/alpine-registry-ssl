# =========================================================================
#
#	Dockerfile
#	  Dockerfile to create docker image used to 
#            create registry self-signed certificates.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package alpine-registry-ssl
# @subpackage Dockerfile
#
# =========================================================================

# =========================================================================
#
#	Copyright © 2017. EarthWalk Software
#	Licensed under the Academic Free License, version 3.0.
#
#	Refer to the file named License.txt provided with the source,
#	or from
#
#		http://opensource.org/licenses/academic.php
#
# =========================================================================

# =========================================================================
#
#    docker run --rm \
#               --name=regssl 
#               -it \
#               -e REG_DOMAIN=internet.lan:5000 \
#               -v /home/$HOME/.certs:/crts \
#               -v /etc/docker/certs.d:/docker \
#               regssl
#
# =========================================================================
FROM nimmis/alpine-micro:latest

MAINTAINER Jay Wheeler <earthwalksoftware@gmail.com>

VOLUME /crts
VOLUME /docker
VOLUME /regbin

ENV REG_CERTS=/crts

ENV REG_DOMAIN="localhost.lan:5000"
ENV REG_DOCKER=/docker
ENV REG_BIN=/regbin

RUN apk update && apk add openssl

COPY registrySSL.sh /
RUN chmod +x /registrySSL.sh

COPY createRegSSL /
RUN chmod +x /createRegSSL

CMD ["/registrySSL.sh"]
