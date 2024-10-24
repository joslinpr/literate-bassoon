# The Book of Knowledge

* [VMWare.md](#vmwaremd)
* [VMWare Vsphere Storage](#vmware-vsphere-storage)
  * [Namespaces](#namespaces)
  * [vmware-system-csi](#vmware-system-csi)
  * [cluster-operations](#cluster-operations)

## VMWare.md

## VMWare Vsphere Storage

### Namespaces

#### vmware-system-csi

1. Controller pods on each Master: vsphere-csi-controller-7f667699db-8z9vt
1. node pods on each Worker: vsphere-csi-node-2jv2s

``` bash
$ oc project vmware-system-csi
$ oc get pods -o wide --show-labels
NAME                                      READY   STATUS    RESTARTS       AGE    IP                NODE                             NOMINATED NODE   READINESS GATES   LABELS
vsphere-csi-controller-7f667699db-8z9vt   7/7     Running   7 (6d6h ago)   11d    10.129.0.14       usqasap0152.phx-dc.dhl.com       <none>           <none>            app=vsphere-csi-controller,pod-template-hash=7f667699db,role=vsphere-csi
vsphere-csi-controller-7f667699db-xpc26   7/7     Running   6 (6d6h ago)   10d    10.130.0.9        usqasap0153.phx-dc.dhl.com       <none>           <none>            app=vsphere-csi-controller,pod-template-hash=7f667699db,role=vsphere-csi
vsphere-csi-controller-7f667699db-zqbx8   7/7     Running   7 (5d1h ago)   11d    10.128.0.14       usqasap0151.phx-dc.dhl.com       <none>           <none>            app=vsphere-csi-controller,pod-template-hash=7f667699db,role=vsphere-csi
vsphere-csi-node-25vtl                    3/3     Running   0              17d    7.244.169.17      usqaslspc005306.phx-dc.dhl.com   <none>           <none>            app=vsphere-csi-node,controller-revision-hash=5dcc566fc,pod-template-generation=2,role=vsphere-csi
vsphere-csi-node-26lc6                    3/3     Running   3              17d    7.244.169.14      usqasap0153.phx-dc.dhl.com       <none>           <none>            app=vsphere-csi-node,controller-revision-hash=5dcc566fc,pod-template-generation=2,role=vsphere-csi


# To check logs, you need to specify the vsphere-csi-node container

$ oc logs vsphere-csi-node-6s28l -c vsphere-csi-node
```

#### cluster-operations

Used to run the Cronjobs and routine jobs for cluster operations and
accounting.

``` bash
$  oc project cluster-operations
Now using project "cluster-operations" on server "https://api.usqasocp001.dhl.com:6443".
$  oc get cronjobs
NAME                                SCHEDULE        SUSPEND   ACTIVE   LAST SCHEDULE   AGE
daily-crosscharging-report          59 23 * * *     False     0        14h             687d
egress-monitoring-image-refresher   @weekly         False     0        5d14h           51d
export-images-for-vmsr              0 04 * * *      False     0        10h             346d
get-groups                          15,45 * * * *   False     0        7m18s           570d
hourly-crosscharging-report         00 * * * *      False     0        22m             687d
operators-zone-monitor              */10 * * * *    False     0        2m18s           292d
prune-builds                        0 0 * * *       False     0        14h             721d
prune-deployments                   0 0 * * *       False     0        14h             721d
prune-images                        0 0 * * *       True      0        716d            718d
prune-pods-jobs                     0 0 * * *       False     0        14h             721d
quota-appbox-label-check            0 1 * * *       False     0        13h             297d
splunk-collectord                   */02 * * * *    False     0        18s             221d
twistlock-user-sync                 02 10 * * *     False     0        4h20m           402d
vsphere-csi-datastore               07,37 * * * *   False     0        15m             177d
zone-utilization                    00 * * * *      False     1        22m             239d


# The vsphere-csi-datastore cronjob runs a sanity check every half hour.  To check the results, view the logs for a pod created by a Job.

Cronjob --> Job --> Pod
$ oc get pods -o wide | grep -E "NAME|vsphere"
NAME                                            READY   STATUS      RESTARTS AGE     IP              NODE                             NOMINATED NODE READINESS GATES
vsphere-csi-datastore-28024567--1-c8t68         0/1     Completed   0 142m    10.130.11.238   usqaslspc005355.phx-dc.dhl.com   <none> <none>
vsphere-csi-datastore-28024597--1-k4v87         0/1     Completed   0 112m    10.131.14.172   usqaslspc005373.phx-dc.dhl.com   <none> <none>
vsphere-csi-datastore-28024627--1-tk5tf         0/1     Completed   0 82m     10.130.53.161   usqaslspc005347.phx-dc.dhl.com   <none> <none>
vsphere-csi-datastore-28024657--1-7dv2z         0/1     Completed   0 52m     10.131.14.179   usqaslspc005373.phx-dc.dhl.com   <none> <none>
vsphere-csi-datastore-28024687--1-m9ndh         0/1     Completed   0 22m     10.131.14.185   usqaslspc005373.phx-dc.dhl.com   <none> <none>
$ oc logs vsphere-csi-datastore-28024687--1-m9ndh
DATE=2023-04-14 14:07:04
CLUSTER_NAME=usqasocp001
DATACENTER=USQASDP001
DATASTORE=/USQASDP001/datastore/CloudBuild/USQAS_SPIP_013_002/LIP013_067
ALLOCATED_CAPACITY_LIMIT=50 %
ALLOCATED_CAPACITY=2323456 MB
ALLOCATED_SPACE=47 %
NUM_OF_PVC=51
NUM_OF_PVC_LIMIT=50
--------------------------------------------------------------------------------
DATE=2023-04-14 14:07:05
CLUSTER_NAME=usqasocp001
DATACENTER=USQASDP001
DATASTORE=/USQASDP001/datastore/CloudBuild/USQAS_SPIP_013_002/LIP013_066
ALLOCATED_CAPACITY_LIMIT=50 %
ALLOCATED_CAPACITY=1632256 MB
ALLOCATED_SPACE=33 %
NUM_OF_PVC=26
NUM_OF_PVC_LIMIT=50
--------------------------------------------------------------------------------
DATE=2023-04-14 14:07:07
CLUSTER_NAME=usqasocp001
DATACENTER=USQASDP001
DATASTORE=/USQASDP001/datastore/CloudBuild/USQAS_SPIP_013_002/LIP013_065
ALLOCATED_CAPACITY_LIMIT=50 %
ALLOCATED_CAPACITY=1465344 MB
ALLOCATED_SPACE=29 %
NUM_OF_PVC=78
NUM_OF_PVC_LIMIT=50
--------------------------------------------------------------------------------
```

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
