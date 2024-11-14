
# The Book of Knowledge

## List The Roles Bound To A User Or Group

## All Users

Use the following commands to list all clusterrolebindings or
rolebindings, and the users and groups bound to them (for the
rolebindings, it is needed to specify also the namespace or -A for
all namespaces):

``` bash

$ oc get clusterrolebindings.authorization
$ oc -n <project> get rolebindings.authorization

```

Note: it is required to include the .authorization to get the output with the users and groups.

To get the role or clusterrole information about a specific user or group, it is possible to filter the desired user or group using awk like:

### To Find An Exact User

``` bash

$ oc get clusterrolebindings.authorization \
      -ocustom-columns=name:.metadata.name,role:.roleRef.name,user:.userNames.* |
      awk -v user=<user> '$3 == user {print}'

```

For example, to filter the clusterroles bound to admin user:

``` bash

$ oc get clusterrolebindings.authorization \
      -ocustom-columns=name:.metadata.name,role:.roleRef.name,user:.userNames.* |
      awk -v user=admin '$3 == user {print}'
cluster-admin-0   cluster-admin  admin

```

* The cluster-admin-0 (first column) is the name of the clusterrolebinding object.
* The cluster-admin (second column) is the name of the clusterrole.
* The admin (third column) is the name of the user bound to the clusterrole from 2nd column  (cluster-admin in this example).

It is also possible to filter users with a specific string:

``` bash

$ oc get clusterrolebindings.authorization \
      -ocustom-columns=name:.metadata.name,role:.roleRef.name,user:.userNames.* |
      awk -v user=<user> '$3 ~ user {print}'

```

   For example, to filter the clusterroles bound to system:admin, admin or \*admin:

``` bash

$ oc get clusterrolebindings.authorization \
      -ocustom-columns=name:.metadata.name,role:.roleRef.name,user:.userNames.* |
      awk -v user=admin '$3 ~ user {print}'

```

For groups, the same logic is applicable, for example, to filter the clusterroles bound to admin group:

``` bash

$ oc get clusterrolebindings.authorization \
      -ocustom-columns=name:.metadata.name,role:.roleRef.name,groups:.groupNames.* |
      awk -v group=admin '$3 ~ group {print}'

```

To identify what a user can do, the following commands can be used:

``` bash

$ oc adm policy who-can
$ oc policy can-i

```

<!-- vim: set ai et nu cin sts=3 sw=3 ts=3 tw=0 filetype=markdown :-->
