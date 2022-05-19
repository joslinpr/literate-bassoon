#      Miscellaneous OpenShift / Kubernetes Tricks

### Get memory usage for a pod
```
$ oc project ecs-am-ramp-sit-cvg
$ oc exec sit-cvg-amp-38-hqscx -- cat /sys/fs/cgroup/memory/memory.usage_in_bytes
```

### Get an interactive shell in a pod
```
$ oc exec -it sit-cvg-amp-38-hqscx -- /bin/bash
```

* -i: interactive
* -t: create a TTY
