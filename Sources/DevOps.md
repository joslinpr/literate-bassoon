# The Book of Knowledge

## DevOps.md

## DevSecOps Tips and Tricks

### Artifactory & Docker

``` bash

$ docker login dhlecsam-docker-dev-fd.artifactory-us.dhl.com -u USERNAME
$ docker tag NAME:VERSION dhlecsam-docker-dev-fd.artifactory-us.dhl.com/devops/NAME:VERSION
$ docker push dhlecsam-docker-dev-fd.artifactory-us.dhl.com/devops/NAME:VERSION

```

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
