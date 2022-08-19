#      Miscellaneous OpenShift / Kubernetes Tricks

## Get memory usage for a pod
```
$ oc project ecs-am-ramp-sit-cvg
$ oc exec sit-cvg-amp-38-hqscx -- cat /sys/fs/cgroup/memory/memory.usage_in_bytes
```

## Get an interactive shell in a pod
```
$ oc exec -it sit-cvg-amp-38-hqscx -- /bin/bash
```

* -i: interactive
* -t: create a TTY

## Get Various Info via CLI:

### Get Auth Token:
You must already be logged in.
```
TOKEN=$(oc whomai --show-token)
```

### POD:
```
oc get po '-o=jsonpath={range .items[*]}{"PROG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.containers[].image}{"\n"}' -A |grep redhat
```

### deployment:
```
oc get deployment '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

### Statefullset:
```
oc get sts '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

### deploymentConfig:
```
oc get dc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

### BuidConfig:
```
oc get bc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.triggers[].imageChange.lastTriggeredImageID}{"\n"}{end}' -A|grep redhat
```

### ImageStream:
```
oc get is '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.tags[].from.name}{"\n"}{end}' -A|grep redhat
```

##     Role-Based Access Controls (RBAC)
[RBAC References](https://docs.openshift.com/container-platform/4.8/authentication/using-rbac.html)

###     Describe all Role-Based Access Controls
` oc describe clusterrole.rbac `

###     Get Clusterrolebindings (CRB) for user/serviceaccount prometheus-server
` oc get clusterrolebindings -o json | jq '.items[] | select(.metadata.name=="prometheus-server")' `

###     Clusterroles (CR) for user/serviceaccount prometheus-server
` oc get clusterroles -o json | jq '.items[] | select(.metadata.name=="prometheus-server")' `

###     Local Role Binding Operations
`$ oc adm policy who-can <verb> <resource>` Indicates which users can perform an action on a resource.

`$ oc adm policy add-role-to-user <role> <username>` Binds a specified role to specified users in the current project.

`$ oc adm policy remove-role-from-user <role> <username>` Removes a given role from specified users in the current project.

`$ oc adm policy remove-user <username>` Removes specified users and all of their roles in the current project.

`$ oc adm policy add-role-to-group <role> <groupname>` Binds a given role to specified groups in the current project.

`$ oc adm policy remove-role-from-group <role> <groupname>` Removes a given role from specified groups in the current project.

`$ oc adm policy remove-group <groupname>` Removes specified groups and all of their roles in the current project.

###     Cluster role binding operations
`$ oc adm policy add-cluster-role-to-user <role> <username>` Binds a given role to specified users for all projects in the cluster.

`$ oc adm policy remove-cluster-role-from-user <role> <username>` Removes a given role from specified users for all projects in the cluster.

`$ oc adm policy add-cluster-role-to-group <role> <groupname>` Binds a given role to specified groups for all projects in the cluster.

`$ oc adm policy remove-cluster-role-from-group <role> <groupname>` Removes a given role from specified groups for all projects in the cluster.


#### Converting json to yaml

[Converting json to yaml](./JSON.md)

[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)