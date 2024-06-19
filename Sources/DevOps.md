# The Book of Knowledge

## DevOps.md

## DevSecOps Tips and Tricks

### Artifactory & Docker

``` bash

$ docker login dhlecsam-docker-dev-fd.artifactory-us.dhl.com -u USERNAME
$ docker tag NAME:VERSION dhlecsam-docker-dev-fd.artifactory-us.dhl.com/devops/NAME:VERSION
$ docker push dhlecsam-docker-dev-fd.artifactory-us.dhl.com/devops/NAME:VERSION

```

### Removing Signatures

If you get the "Error: Copying this image would require changing layer
representation, which we cannot do: Would invalidate signatures" error
message, there are two solutions, according to this
[RH Knowledgebase Article](https://access.redhat.com/solutions/6568941).

1. Using `skopeo copy` or `skopeo sync`.  This is also more efficient,
since it doesn't uncompress or unpack the artifact.
`skopeo sync --src docker --dest docker SRC_REPO/NAME:VERSION DEST_REPO/NAME:VERSION`.

2. Use --remove-signatures: `podman push --remove-signatures
   REPO/NAME:VERSION`

### Unauthorized

If you get an error message with "FATA[0001] ... unauthorized: No permission to write manifest"
use `skopeo sync --dest docker --src docker` to add the artifact.

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
