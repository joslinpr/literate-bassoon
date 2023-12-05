# The Book of Knowledge

<!-- TOC start -->

- [OpenShiftNetwork.md](#openshiftnetworkmd)
- [Miscellaneous OpenShift / Kubernetes Network Tricks](#miscellaneous-openshift-kubernetes-network-tricks)
* [Get Ingress Router Logs](#get-ingress-router-logs)

<!-- TOC end -->
<!-- TOC --><a name="openshiftnetworkmd"></a>

## OpenShiftNetwork.md

<!-- TOC --><a name="miscellaneous-openshift-kubernetes-network-tricks"></a>

## Miscellaneous OpenShift / Kubernetes Network Tricks

<!-- TOC --><a name="get-ingress-router-logs"></a>

### Get Ingress Router Logs

Namespace is openshift-ingress; router pods are router-default.

``` bash

$ oc get pods -n openshift-ingress
NAME                                       READY   STATUS    RESTARTS   AGE
router-default-77d568d5-mngtx              2/2     Running   0          116d
router-default-77d568d5-rr25w              2/2     Running   0          116d
router-dmz-prod-app-7748b6976d-5glwd       2/2     Running   0          116d
router-dmz-prod-app-7748b6976d-x6hns       2/2     Running   0          116d
router-internal-prod-app-ff4bcdcc6-6cm9t   2/2     Running   0          116d
router-internal-prod-app-ff4bcdcc6-954ps   2/2     Running   0          116d
router-internal-prod-app-ff4bcdcc6-pgprj   2/2     Running   0          116d

```

This script saves the output of the logs to timestamped files.

``` bash

#!/usr/bin/env bash

PODS=$(oc get pods -n openshift-ingress | grep router-default | cut -d" " -f1)
for POD in $PODS
do
    TIMESTAMP=$(date +"%Y%m%d-%T")
    # Dark Voodoo Bash magic
    OUT=LOG-${POD#${POD%?????}}."$TIMESTAMP"
    printf "Getting %s as %s &\n" "$POD" "$OUT" >&2
    oc logs -n openshift-ingress %s -c logs > %s &\n" "$POD" "$OUT
    OFILES+="$OUT "
done
wait
printf "Files in %s\n" "$OFILES"

# vim: set ai et nu cin sts=2 sw=2 ts=2 tw=0 filetype=sh :

```

<!-- vim: set ai et nu cin sts=2 sw=2 ts=2 tw=100 filetype=markdown :-->
[//]: # ( vim: set ai noet nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
