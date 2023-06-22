#  Book of Knowledge
<!-- TOC --><a name="openshifttricksmd"></a>
##  OpenShiftTricks.md
<!-- TOC --><a name="miscellaneous-openshift-kubernetes-tricks"></a>
##  Miscellaneous OpenShift / Kubernetes Tricks
<!-- TOC start -->
- [Get memory, resource usage for a pod](#get-memory-resource-usage-for-a-pod)
- [Get an interactive shell in a pod](#get-an-interactive-shell-in-a-pod)
- [Get an interactive shell on a node](#get-an-interactive-shell-on-a-node)
- [Get Various Info via CLI:](#get-various-info-via-cli)
  * [Get Auth Token:](#get-auth-token)
  * [Pod:](#pod)
  * [Deployment:](#deployment)
  * [Statefullset:](#statefullset)
  * [DeploymentConfig:](#deploymentconfig)
  * [BuidConfig:](#buidconfig)
  * [ImageStream:](#imagestream)
  * [Listing Users](#listing-users)
  * [Listing Groups](#listing-groups)
  * [Specific Action/resource Permissions For a Specific User](#specific-actionresource-permissions-for-a-specific-user)
  * [To List All Permissions For a Specific User](#to-list-all-permissions-for-a-specific-user)
  * [Same For A Groups Ex.:](#same-for-a-groups-ex)
- [Role-Based Access Controls (RBAC)](#role-based-access-controls-rbac)
  * [Describe all Role-Based Access Controls](#describe-all-role-based-access-controls)
  * [Get Clusterrolebindings (CRB) for user/serviceaccount prometheus-server](#get-clusterrolebindings-crb-for-userserviceaccount-prometheus-server)
  * [Clusterroles (CR) for user/serviceaccount prometheus-server](#clusterroles-cr-for-userserviceaccount-prometheus-server)
  * [Local Role Binding Operations](#local-role-binding-operations)
  * [Cluster role binding operations](#cluster-role-binding-operations)
  * [Converting json to yaml](#converting-json-to-yaml)
- [Who's using kafka?](#whos-using-kafka)
- [Enable/Disable Cronjobs](#enabledisable-cronjobs)
<!-- TOC end -->

<!-- TOC --><a name="get-memory-resource-usage-for-a-pod"></a>
###  Get memory, resource usage for a pod
```
$ oc project ecs-am-ramp-sit-cvg
$ oc exec sit-cvg-amp-38-hqscx -- cat /sys/fs/cgroup/memory/memory.usage_in_bytes
# For all running pods in a namespace, use PODMetrics
$ oc get PODMetrics
```

<!-- TOC --><a name="get-an-interactive-shell-in-a-pod"></a>
###  Get an interactive shell in a pod
```
$ oc exec -it sit-cvg-amp-38-hqscx -- /bin/bash
```

* -i: interactive
* -t: create a TTY

<!-- TOC --><a name="get-an-interactive-shell-on-a-node"></a>
###  Get an interactive shell on a node
```
$ oc debug -n default debug/<nodename>
```

* Use "chroot /hosts" to access host instead of container
* You must specify a namespace that does not have a quota.

<!-- TOC --><a name="get-various-info-via-cli"></a>
###  Get Various Info via CLI:

<!-- TOC --><a name="get-auth-token"></a>
####  Get Auth Token:
You must already be logged in.
```
TOKEN=$(oc whomai --show-token)
```

<!-- TOC --><a name="pod"></a>
####  Pod:
```
oc get po '-o=jsonpath={range .items[*]}{"PROG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.containers[].image}{"\n"}' -A |grep redhat

oc get PODMetrics # Resource Usage for all Running Pods in a Namespace
```

<!-- TOC --><a name="deployment"></a>
####  Deployment:
```
oc get deployment '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

<!-- TOC --><a name="statefullset"></a>
####  Statefullset:
```
oc get sts '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

<!-- TOC --><a name="deploymentconfig"></a>
####  DeploymentConfig:
```
oc get dc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat
```

<!-- TOC --><a name="buidconfig"></a>
####  BuidConfig:
```
oc get bc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.triggers[].imageChange.lastTriggeredImageID}{"\n"}{end}' -A|grep redhat
```

<!-- TOC --><a name="imagestream"></a>
####  ImageStream:
```
oc get is '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.tags[].from.name}{"\n"}{end}' -A|grep redhat
```

<!-- TOC --><a name="listing-users"></a>
#### Listing Users
```
$ oc get users
```

<!-- TOC --><a name="listing-groups"></a>
#### Listing Groups
```
$ oc get groups
```

<!-- TOC --><a name="specific-actionresource-permissions-for-a-specific-user"></a>
#### Specific Action/resource Permissions For a Specific User
```
$ oc auth can-i create configmap --as=<user>
```

<!-- TOC --><a name="to-list-all-permissions-for-a-specific-user"></a>
#### To List All Permissions For a Specific User
```
$ oc auth can-i --as=<user> --list
# As Yourself
$ oc auth can-i --list
```

<!-- TOC --><a name="same-for-a-groups-ex"></a>
#### Same For A Groups Ex.:
```
$ oc get groups
$ oc auth can-i --as-group=<group> --list
```
<!-- TOC --><a name="role-based-access-controls-rbac"></a>
###  Role-Based Access Controls (RBAC)
[RBAC References](https://docs.openshift.com/container-platform/4.9/authentication/using-rbac.html)

<!-- TOC --><a name="describe-all-role-based-access-controls"></a>
####  Describe all Role-Based Access Controls
` oc describe clusterrole.rbac `

<!-- TOC --><a name="get-clusterrolebindings-crb-for-userserviceaccount-prometheus-server"></a>
####  Get Clusterrolebindings (CRB) for user/serviceaccount prometheus-server
` oc get clusterrolebindings -o json | jq '.items[] | select(.metadata.name=="prometheus-server")' `

<!-- TOC --><a name="clusterroles-cr-for-userserviceaccount-prometheus-server"></a>
####  Clusterroles (CR) for user/serviceaccount prometheus-server
` oc get clusterroles -o json | jq '.items[] | select(.metadata.name=="prometheus-server")' `

<!-- TOC --><a name="local-role-binding-operations"></a>
####  Local Role Binding Operations
`$ oc adm policy who-can <verb> <resource>` Indicates which users can perform an action on a resource.

`$ oc adm policy add-role-to-user <role> <username>` Binds a specified role to specified users in the current project.

`$ oc adm policy remove-role-from-user <role> <username>` Removes a given role from specified users in the current project.

`$ oc adm policy remove-user <username>` Removes specified users and all of their roles in the current project.

`$ oc adm policy add-role-to-group <role> <groupname>` Binds a given role to specified groups in the current project.

`$ oc adm policy remove-role-from-group <role> <groupname>` Removes a given role from specified groups in the current project.

`$ oc adm policy remove-group <groupname>` Removes specified groups and all of their roles in the current project.

<!-- TOC --><a name="cluster-role-binding-operations"></a>
####  Cluster role binding operations
`$ oc adm policy add-cluster-role-to-user <role> <username>` Binds a given role to specified users for all projects in the cluster.

`$ oc adm policy remove-cluster-role-from-user <role> <username>` Removes a given role from specified users for all projects in the cluster.

`$ oc adm policy add-cluster-role-to-group <role> <groupname>` Binds a given role to specified groups for all projects in the cluster.

`$ oc adm policy remove-cluster-role-from-group <role> <groupname>` Removes a given role from specified groups for all projects in the cluster.


<!-- TOC --><a name="converting-json-to-yaml"></a>
####  Converting json to yaml

[Converting json to yaml](./JSON.md)

<!-- TOC --><a name="whos-using-kafka"></a>
###  Who's using kafka?
```
$ oc get kafka --all-namespaces
```

<!-- TOC --><a name="enabledisable-cronjobs"></a>
### Enable/Disable Cronjobs
```
$ oc patch cronjobs <job-name> -p '{"spec" : {"suspend" : true }}' -n <namespace>
$ oc patch cronjobs <job-name> -p '{"spec" : {"suspend" : false }}' -n <namespace>
```
[//]: # ( vim: set ai et nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
