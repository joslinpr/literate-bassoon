# Cleaning up Deleted Namespace

## Check NS Deletion

``` bash

oc get ns | grep dgf

```

### Check For Common Items (Routes, Services, Deployments, Etc.)

``` bash

oc get -n dgf-edm-us-prd all
oc get -n dgf-edm-us-prod all

```

## Service Accounts (including Cloudmgmt)

``` bash

oc get sa -A
oc delete sa    svc-its-pjoslin-test-admin
oc delete -n cloudmgmt  sa    svc-its-pjoslin-test-admin
oc delete -n cloudmgmt  sa    svc-dgf-edm-us-dmz-prod
oc delete -n cloudmgmt  sa    svc-dgf-edm-us-prod
oc get sa -A | grep dgf

```

## Rolebindings

``` bash

oc get rolebinding -A
oc get rolebinding -A | grep dgf

```

## Roles and ClusterRoles

``` bash

oc get roles -A | grep dgf
oc get clusterroles -A | grep dgf
for i in $(oc get clusterrolebindings -A | grep dgf | cut -d" " -f1);
do
    echo $i;
    oc get -o yaml clusterrolebindings $i | oc neat -f - > ${i}.yaml;
    oc delete clusterrolebindings $i;
done
oc get clusterrolebindings. -A | grep dgf

```

## Quotas

``` bash

oc get clusterresourcequotas.quota.openshift.io
oc delete clusterresourcequotas.quota.openshift.io quota-svc-dgf-edm-us-prod
oc delete clusterresourcequotas.quota.openshift.io quota-svc-dgf-edm-us-dmz-prod

```

## Groups - Discuss With PAAS Team

``` bash

oc get groups | grep dgf
oc get groups | grep  -i OCPTeam

```

### Might Want To Save For Reuse

``` bash

for i in $(oc get groups | grep OCPTeam-dgf | cut -d" " -f 1)
do
    oc get group -o yaml $i | oc neat -f - > ${i}.yaml &&
      oc delete $i
done

```

<!-- vim: set ai cin et filetype=markdown nu nosi sts=3 sw=3 spell ts=3 tw=0 :-->
