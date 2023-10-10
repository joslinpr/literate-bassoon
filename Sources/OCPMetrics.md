##  OCPMetrics
##	Resource Usage and Quotas in OpenShift Container Platform
###	Pod - Metrics
Get current usage (cpu, memory) for all running pods in the current namespace.
Use `--all-namespaces` and `--no-headers` as needed.
```
$ oc get PODMetrics
NAME                                           CPU    MEMORY WINDOW
api-newops-data-76b4c9dfcc-79jqc               0      424772Ki 5m0s
api-ramp-machine-sorting-7f5d79f755-8z644      1m     454840Ki 5m0s
api-ramp-machine-sorting-7f5d79f755-dk6ht      1m     491500Ki 5m0s
api-ramp-machine-sorting-7f5d79f755-mks28      1m     480784Ki 5m0s
...
```

###	Pods Not Running
Use `-ns NAMESPACE` if needed. .status.phase is usually "Running" or
"Succeeded".  You can filter one or both out.
File:
``` bash
#!/usr/bin/env bash
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
OFILE=PodsAllNamespaces.$TIMESTAMP.json
printf "Output in %s.\n" "$OFILE"
oc get pods --all-namespaces -o json |
    jq '.items[] | select(.status.phase != "Running") | {"name": .metadata.name, "namespace": .metadata.namespace, "phase": .status.phase , "containerState": .status.containerStatuses[]?.state}' > "$OFILE"

```
Output:
``` json
 $  head -40 PodsAllNamespaces.20230524-095113.json
{
  "name": "export-images-for-vmsr-28081680--1-45sl4",
  "namespace": "cluster-operations",
  "phase": "Succeeded",
  "containerState": {
    "terminated": {
      "containerID": "cri-o://4bccea0350019e7fa808546208a2c919987a87d3b76775458ad2e6fec8b6da77",
      "exitCode": 0,
      "finishedAt": "2023-05-24T04:00:46Z",
      "reason": "Completed",
      "startedAt": "2023-05-24T04:00:03Z"
    }
  }
}
```
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
