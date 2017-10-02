#!/bin/sh
# =========================================================================
#
#	registrySSL
#	  Shell script to create SSL certificates and exit.
#
# =========================================================================
#
# @author Jay Wheeler.
# @version 0.0.1
# @copyright © 2017. EarthWalk Software.
# @license Licensed under the Academic Free License version 3.0
# @package alpine-registry-ssl
# @subpackage registrySSL
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
#           earthwalksoftware/alpine-registry-ssl:latest
#
# =========================================================================

mkdir -p $REG_DOCKER
mkdir -p /docker/$REG_DOMAIN:$REG_PORT

openssl req \
  -newkey rsa:4096 -nodes -sha256 -keyout /crts/domain.key \
  -x509 -days 365 -out /crts/domain.crt

cp $REG_CERTS/domain.crt /docker/$REG_DOMAIN:$REG_PORT/ca.crt

cp /createRegSSL $REG_BIN/createRegSSL

chown $REG_UID:$REG_GID $REG_BIN
chown $REG_UID:$REG_GID $REG_BIN/createRegSSL
