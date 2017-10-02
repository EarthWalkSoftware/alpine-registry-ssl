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
#               --name=regssl \
#               -it \
#               -p 5000:5000 \
#               -e REG_UID=$(id -u) \
#               -e REG_GID=$(id -g) \
#               -e REG_DOMAIN=internet.lan \
#               -v $HOME/.certs:/crts \
#               -v $HOME/bin:/regbin \
#               -v /etc/docker/certs.d:/docker \
#               regssl
#
# =========================================================================
FROM nimmis/alpine-micro:latest

MAINTAINER Jay Wheeler <earthwalksoftware@gmail.com>

ENV REG_CERTS=/crts

ENV REG_PORT=5000
ENV REG_DOMAIN=localhost.lan
ENV REG_DOCKER=/docker
ENV REG_BIN=/regbin

ENV REG_UID=0
ENV REG_GID=0

VOLUME /crts
VOLUME /docker
VOLUME /regbin

RUN apk update && apk add openssl

COPY registrySSL.sh /
RUN chmod +x /registrySSL.sh

COPY createRegSSL /
RUN chmod +x /createRegSSL

CMD ["/registrySSL.sh"]
