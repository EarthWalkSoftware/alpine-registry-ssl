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
#               --name=regssl 
#               -it \
#               -e REG_DOMAIN=internet.lan:5000 \
#               -v $HOME/.certs:/crts \
#               -v /etc/docker/certs.d:/docker \
#               -v $HOME/bin:/regbin
#     earthwalksoftware/docker-registry-ssl
#
# =========================================================================

mkdir -p $REG_DOCKER
mkdir -p /docker/$REG_DOMAIN

openssl req \
  -newkey rsa:4096 -nodes -sha256 -keyout /crts/domain.key \
  -x509 -days 365 -out /crts/domain.crt

cp $REG_CERTS/domain.crt /docker/$REG_DOMAIN/ca.crt

cp -rf /createRegSSL /regbin/createRegSSL
