## alpine-registry-ssl
## Overview of docker-registry-ssl
*docker-registry-ssl* creates a temporary Alpine Linux container, based upon *nimmis/alpine-micro*, that implements an interactive console-based ssl certificate generator using openssl.  The generated certificates are stored in a user-specified folder, and the ca.crt certificate is stored in the required docker folder.

This document gives an overview of how to install and run the docker-registry-ssl container. For more in-depth details, visit (still under construction).

#### EarthWalkSoftware/alpine-registry-ssl on GitHub
 https://github.com/EarthWalkSoftware/alpine-registry-ssl
____________
#### NOTES:  
1. The *alpine-registry-ssl* site referenced below (most notably, reference to the *wiki*) is still under construction.  
2. The current docker pull should contain the current *testing tag* (*0.0.1*), not the *development tag* (*dev*). 

 pull earthwalksoftware/docker-registry-ssl:0.0.1  

3. No *latest* tag (*latest*) is available until *0.0.1* has completed testing.  Refer to *Versioning*, below.
______________
### Quick Start

 The following docker run command will generate a *Self-Signed SSL Certificate* for use with Docker registry:2. 

    docker run --rm \
               --name=regssl \
               -it \
               -e REG_UID=$(id -u) \
               -e REG_GID=$(id -g) \
               -e REG_DOMAIN=internet.lan \
               -e REG_PORT=5000 \
               -v $HOME/bin:/regbin \
               -v $HOME/.certs:/crts \
               -v /etc/docker/certs.d:/docker \
           earthwalksoftware/docker-registry-ssl:0.0.1

Two certificates, *domain.key* and *domain.crt*, will be placed in the *.certs* folder of the user's home directory.   

A folder named *internet.lan:5000*, containing *ca.crt* copied from *domain.crt*, will be placed in the /etc/docker/certs.d folder (/etc/docker/certs.d/internet.lan:5000/ca.crt).  The internet.lan:5000 folder must be copied to the same location on each docker host requiring access to the private docker registry.

A shell script containing the docker run command entered above will also be created in the /regbin folder ($HOME/bin, above).  This script may be run anytime that a new certificate must be generated.

Refer to the docker documentation on "Use self-signed certificates" at  
 https://docs.docker.com/registry/insecure/#use-self-signed-certificates

---------------------

### Options
 All options are CASE sensitive and, of course, OPTIONAL

There are 3 types of command-line options:
  - Docker run-time options (or flags)
  - Mount-point (or Volume) Options
  - Environment Options

---------------------
### Docker Options

 #### -e Set Environment Variable
  sets a (container) environment value.
    For example,  -e REG_PORT=5000

 #### -v Volume mount-point
  mounts an external (docker host) directory to an internal (container) directory.  Any
  changes to the internal directory are recorded in the external directory.
    For example,  -v /home/user/.certs:/crts

 #### --name Set container run-time name
  Creates a name to reference the container by.
    For example,  --name=regssl

---------------------
### Volume (Mount-Point) Options

  #### /crts

   The path to the external (docker host) folder to place the generated certificates.  If not provided, NO CERTIFICATES WILL BE GENERATED.  
  #### /docker

   The path to the folder to store the ca.crt certificate for the specified domain.  The default is /etc/docker/certs.d

  #### /regbin
   The path to the folder to store the createRegSSL script.  The default is /regbin, which is an internal folder.  If /regbin is NOT provided, NO createRegSSL script will be created.

---------------------
### Environment Options
 #### REG_BIN  
   The path to the location to store the createRegSSL script.
 #### REG_CERTS
   The path to the location to store the generated certificates domain.key and domain.crt in.
 #### REG_DOCKER  
   The path to the folder to store the ca.crt certificate in. 
 #### REG_DOMAIN  
   The name of the internet domain of the generated certificates 
 #### REG_GID  
   The user's group id - used for /bin ownership
 #### REG_UID  
   The user's id - used for /bin ownership
 #### REG_PORT  
   The value of the internet port to use for docker registry communication

---------------------

### Versioning
#### latest 
   The (default) version is known as "latest".  It will provide the latest (highest numbered) released version.  
#### dev
   The development version will be tagged "dev", and should not be trusted.
#### Numeric (0.0.1)
   The highest numeric tag version corresponds to the "latest" version.  Lower numeric tags represent older versions, available under the Tags selection at the top of the page.

---------------------
#### Get the source from GitHub:  
 https://github.com/EarthWalkSoftware/alpine-registry-ssl

_____________________

For details about the scripts, and how to customize the docker image and source, visit  

https://github.com/EarthWalkSoftware/alpine-registry-ssl/wiki  

_____________________

by Jay Wheeler, EarthWalk Software
2017-10-01.
_____________________

#### Licensed by Academic Free License v 3.0  

 Read the license at 
    https://github.com/EarthWalkSoftware/alpine-registry-ssl/wiki/License
_____________________

