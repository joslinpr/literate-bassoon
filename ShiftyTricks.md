#	Book of Knowledge
##	ShiftyTricks.md
##	Miscellaneous OpenShift / Kubernetes Tricks

###	Get memory usage for a pod
```
$ oc project ecs-am-ramp-sit-cvg
$ oc exec sit-cvg-amp-38-hqscx -- cat /sys/fs/cgroup/memory/memory.usage_in_bytes
```

###	Get an interactive shell in a pod
```
$ oc exec -it sit-cvg-amp-38-hqscx -- /bin/bash
```

* -i: interactive
* -t: create a TTY

###	Get Various Info from Registry via CLI:

#### POD:
```
oc get po '-o=jsonpath={range .items[*]}{"PROG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.containers[].image}{"\n"}' -A |grep redhat
```

#### Deployment:
```
oc get deployment '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

#### Statefullset:
```
oc get sts '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

#### DeploymentConfig:
```
oc get dc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

#### BuidConfig:
```
oc get bc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.triggers[].imageChange.lastTriggeredImageID}{"\n"}{end}' -A|grep redhat
```

#### ImageStream:
```
oc get is '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.tags[].from.name}{"\n"}{end}' -A|grep redhat
```
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)