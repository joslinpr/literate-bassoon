# The Book of Knowledge

* [OpenShiftTricks.md](#openshifttricksmd)
* [Miscellaneous OpenShift / Kubernetes Tricks](#miscellaneous-openshift--kubernetes-tricks)
  * [Login as Installer](#login-as-installer)
  * [Get memory, resource usage for a pod](#get-memory-resource-usage-for-a-pod)
  * [Get an interactive shell in a pod](#get-an-interactive-shell-in-a-pod)
  * [Get an interactive shell on a node](#get-an-interactive-shell-on-a-node)
  * [Get Various Info via CLI](#get-various-info-via-cli)
    * [Get Auth Token](#get-auth-token)
    * [Pod](#pod)
    * [Deployment](#deployment)
    * [Statefullset](#statefullset)
    * [DeploymentConfig](#deploymentconfig)
    * [BuidConfig](#buidconfig)
    * [ImageStream](#imagestream)
    * [Listing Users](#listing-users)
    * [Listing Groups](#listing-groups)
    * [Specific Action/resource Permissions For a Specific User](#specific-actionresource-permissions-for-a-specific-user)
    * [To List All Permissions For a Specific User](#to-list-all-permissions-for-a-specific-user)
    * [Same For A Groups (Example)](#same-for-a-groups-example)
      * [Role-Based Access Controls (RBAC)](#role-based-access-controls-rbac)
        * [Describe all Role-Based Access Controls](#describe-all-role-based-access-controls)
        * [Get Clusterrolebindings (CRB) for user/serviceaccount prometheus-server](#get-clusterrolebindings-crb-for-userserviceaccount-prometheus-server)
        * [Clusterroles (CR) for user/serviceaccount prometheus-server](#clusterroles-cr-for-userserviceaccount-prometheus-server)
        * [All Accounts with cluster-wide cluster-admin](#all-accounts-with-cluster-wide-cluster-admin)
        * [Local Role Binding Operations](#local-role-binding-operations)
        * [Cluster role binding operations](#cluster-role-binding-operations)
        * [Converting json to yaml](#converting-json-to-yaml)
    * [Who's using kafka?](#whos-using-kafka)
    * [Enable/Disable Cronjobs](#enabledisable-cronjobs)
    * [Request a login token](#request-a-login-token)

## OpenShiftTricks.md

## Miscellaneous OpenShift / Kubernetes Tricks

### Login as Installer

Login to the bastion host, then `export KUBECONFIG=~/installation_directory/auth/kubeconfig`.
Test by running `oc whoami`, which should return `system:admin`.

### Get memory, resource usage for a pod

``` bash

$ oc project ecs-am-ramp-sit-cvg
$ oc exec sit-cvg-amp-38-hqscx -- cat /sys/fs/cgroup/memory/memory.usage_in_bytes

# For all running pods in a namespace, use PODMetrics

$ oc get PODMetrics

```

### Get an interactive shell in a pod

``` bash

$ oc exec -it sit-cvg-amp-38-hqscx -- /bin/bash

```

* \-i: interactive
* \-t: create a TTY

### Get an interactive shell on a node

``` bash

$ oc debug -n default debug/<nodename>

```

* Use "chroot /hosts" to access host instead of container
* You must specify a namespace that does not have a quota.

### Get Various Info via CLI

#### Get Auth Token

You must already be logged in.

``` bash

TOKEN=$(oc whomai --show-token)

```

#### Pod

``` bash

oc get po '-o=jsonpath={range .items[*]}{"PROG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.containers[].image}{"\n"}' -A |grep redhat
oc get PODMetrics # Resource Usage for all Running Pods in a Namespace

```

#### Deployment

``` bash

oc get deployment '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat

```

#### Statefullset

``` bash

oc get sts '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat

```

#### DeploymentConfig

``` bash

oc get dc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.spec.template.spec.containers[].name}{","}{.spec.template.spec.containers[].image}{"\n"}' -A|grep redhat

```

#### BuidConfig

``` bash

oc get bc '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.triggers[].imageChange.lastTriggeredImageID}{"\n"}{end}' -A|grep redhat

```

#### ImageStream

``` bash

oc get is '-o=jsonpath={range .items[*]}{"PRG_TEST"},{.metadata.namespace}{","}{.metadata.name}{","}{.spec.tags[].from.name}{"\n"}{end}' -A|grep redhat

```

#### Listing Users

``` bash

$ oc get users

```

#### Listing Groups

``` bash

$ oc get groups

```

#### Specific Action/resource Permissions For a Specific User

``` bash

$ oc auth can-i create configmap --as=<user>

# Note this differs from --user, which tells the oc command which

# kubeconfig entry to use.

```

#### To List All Permissions For a Specific User

``` bash

$ oc auth can-i --as=<user> --list

# As Yourself

$ oc auth can-i --list

```

#### Same For A Groups (Example)

``` bash

$ oc get groups
$ oc auth can-i --as-group=<group> --list

```

### Role-Based Access Controls (RBAC)

[RBAC References](https://docs.openshift.com/container-platform/4.9/authentication/using-rbac.html)

#### Describe all Role-Based Access Controls

` oc describe clusterrole.rbac `

#### Get Clusterrolebindings (CRB) for user/serviceaccount prometheus-server

` oc get clusterrolebindings -o json | jq '.items[] | select(.metadata.name=="prometheus-server")' `

#### Clusterroles (CR) for user/serviceaccount prometheus-server

` oc get clusterroles -o json | jq '.items[] | select(.metadata.name=="prometheus-server")' `

#### All Accounts with cluster-wide cluster-admin

`$ oc get clusterrolebinding -o json | jq '.items[] | select(.metadata.name | startswith("cluster-admin")) | .subjects[].name'`

#### Local Role Binding Operations

`$ oc adm policy who-can <verb> <resource>` Indicates which users can perform an action on a resource.
`$ oc adm policy add-role-to-user <role> <username>` Binds a specified role to specified users in the current project.
`$ oc adm policy remove-role-from-user <role> <username>` Removes a given role from specified users in the current project.
`$ oc adm policy remove-user <username>` Removes specified users and all of their roles in the current project.
`$ oc adm policy add-role-to-group <role> <groupname>` Binds a given role to specified groups in the current project.
`$ oc adm policy remove-role-from-group <role> <groupname>` Removes a given role from specified groups in the current project.
`$ oc adm policy remove-group <groupname>` Removes specified groups and all of their roles in the current project.

#### Cluster role binding operations

`$ oc adm policy add-cluster-role-to-user <role> <username>` Binds a given role to specified users for all projects in the cluster.
`$ oc adm policy remove-cluster-role-from-user <role> <username>` Removes a given role from specified users for all projects in the cluster.
`$ oc adm policy add-cluster-role-to-group <role> <groupname>` Binds a given role to specified groups for all projects in the cluster.
`$ oc adm policy remove-cluster-role-from-group <role> <groupname>` Removes a given role from specified groups for all projects in the cluster.

#### Converting json to yaml

[Converting json to yaml](./JSON.md)

### Who's using kafka?

``` bash

$ oc get kafka --all-namespaces

```

### Enable/Disable Cronjobs

``` bash

$ oc patch cronjobs <job-name> -p '{"spec" : {"suspend" : true }}' -n <namespace>
$ oc patch cronjobs <job-name> -p '{"spec" : {"suspend" : false }}' -n <namespace>

```

### Request a login token

``` bash

$ OAUTH=$(oc get route oauth-openshift -n openshift-authentication -o json | jq .spec.host)

# In browser:

    https://$OAUTH/oauth/token/request

```

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
