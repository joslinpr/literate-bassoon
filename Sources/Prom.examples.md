# The Book of Knowledge

- [The Book of Knowledge](#the-book-of-knowledge)
  * [Prom.examples.md](#promexamplesmd)
  * [Prometheus Query Examples](#prometheus-query-examples)
    + [Infra Nodes](#infra-nodes)
    + [Number of containers by cluster and namespace without CPU limits](#number-of-containers-by-cluster-and-namespace-without-cpu-limits)
    + [Count of pods per cluster and namespace](#count-of-pods-per-cluster-and-namespace)
    + [CPU USage per namespace](#cpu-usage-per-namespace)
    + [CPU Usage per selected pod by Namespace](#cpu-usage-per-selected-pod-by-namespace)
    + [CPU overcommit](#cpu-overcommit)
    + [Kafka Disk Space Available](#kafka-disk-space-available)
    + [Network by workload: pod, namespace, interface](#network-by-workload-pod-namespace-interface)
    + [CPU Usage in OpenShift](#cpu-usage-in-openshift)
    + [Find Pods killed by OOM](#find-pods-killed-by-oom)
    + [Find Highest PVC Utilization](#find-highest-pvc-utilization)

## Prom.examples.md

## Prometheus Query Examples

### Infra Nodes

``` bash

sort_desc(sum by (cpu,id,pod_name,container_name) (rate(container_cpu_usage_seconds_total{type="infra"}[5m])))

```

### Number of containers by cluster and namespace without CPU limits

``` bash

count by (namespace)(sum by (namespace,pod,container)(kube_pod_container_info{container!=""}) unless sum by (namespace,pod,container)(kube_pod_container_resource_limits{resource="cpu"})

```

### Count of pods per cluster and namespace

``` bash

sum by (namespace) (kube_pod_info)))

```

### CPU USage per namespace

``` bash

sort_desc(sum by (namespace) (rate(container_cpu_usage_seconds_total[5m])))

```

### CPU Usage per selected pod by Namespace

``` bash

sum by (pod) (rate (container_cpu_usage_seconds_total{container!="",pod=~"service-label-generator.+",namespace=~"ecs-am-ramp-webapps-prd"}[1m]))

```

### CPU overcommit

CPU limits over the capacity of the cluster is a scenario you need to avoid. Otherwise, you’ll end up with CPU throttling issues. You can detect CPU overcommit with the following query.

``` bash

sum(kube_pod_container_resource_limits{resource="cpu"}) - sum(kube_node_status_capacity_cpu_cores)

```

### Kafka Disk Space Available

``` bash

# data-kafka-copy-kafka-*

kubelet_volume_stats_available_bytes{persistentvolumeclaim=~"data-kafka-copy-k.*"}

# data-kafka-copy-zookeeper-*

kubelet_volume_stats_available_bytes{persistentvolumeclaim=~"data-kafka-copy-z.*"}

# data-kafka-kafka-*

kubelet_volume_stats_available_bytes{persistentvolumeclaim=~"data-kafka-k.*"}

# data-kafka-zookeeper-*

kubelet_volume_stats_available_bytes{persistentvolumeclaim=~"data-kafka-z.*"}

```

### Network by workload: pod, namespace, interface

``` bash

(sum(irate(container_network_receive_bytes_total{namespace='ecs-am-ramp-webapps-prd',pod=~'api-label.+'}[1m]))
 by (pod, namespace, interface)) +
  on(namespace,pod,interface) group_left(network_name) ( pod_network_name_info )

```

### CPU Usage in OpenShift

The **container_cpu_usage_seconds_total** is a counter, e.g. it increases
over time. This isn't very informative for determining CPU usage at
a particular time. Prometheus provides **rate()** function, which returns
the average per-second increase rate over counters. For example, the
following query returns the average per-second increase of per-container
**container_cpu_usage_seconds_total** metrics over the last 5 minutes (see
5m lookbehind window in square brackets):
`rate(container_cpu_usage_seconds_total[5m])`
This is basically the average number of CPU cores used during the last
5 minutes. Just multiply it by 100 in order to get CPU usage in %. Note
that the resulting value may exceed 100% if the container uses more than
a single CPU core during the last 5 minutes.
The **rate(container_cpu_usage_seconds_total[5m])** usually returns
a TON of time series with many long labels in production Kubernetes,
so it is better to use the following queries:
The average number of CPU cores used during the last 5 minutes per each pod:

``` bash

sum(rate(container_cpu_usage_seconds_total{container!=""}[5m])) by (pod)

```

The average number of CPU cores used during the last 5 minutes per each node:

``` bash

sum(rate(container_cpu_usage_seconds_total{container!=""}[5m])) by (node)

```

The average number of CPU cores used during the last 5 minutes per each namespace:

``` bash

sum(rate(container_cpu_usage_seconds_total{container!=""}[5m])) by (namespace)

```

The **container!=""** filter removes superfluous metrics related to cgroups hierarchy - see [this answer](https://stackoverflow.com/questions/69281327/why-container-memory-usage-is-doubled-in-cadvisor-metrics/69282328#69282328) for more details.
[Source](https://stackoverflow.com/questions/34923788/prometheus-convert-cpu-user-seconds-to-cpu-usage)

### Find Pods killed by OOM

``` bash

"kube_pod_container_status_last_terminated_reason{reason="OOMKilled"} >=1"

```

### Find Highest PVC Utilization

The entire query identifies the top 20 PVCs with the highest utilization
percentages in namespaces that contain "ecs-am."

``` bash

topk(20,
(sum by (namespace, persistentvolumeclaim)
 (kubelet_volume_stats_used_bytes{namespace=~".*ecs-am.*"}) /
sum by (namespace, persistentvolumeclaim)
 (kubelet_volume_stats_capacity_bytes{namespace=~".*ecs-am.*"}))
*100)

```

Explanation of Each Component:
1. `topk(20, ...)`:
This function is used to retrieve the top 20 entries based on the value
calculated in the inner expression. It sorts the results in descending
order and selects the highest values.
2. Inner Expression:
This part of the query calculates the utilization percentage
of Persistent Volume Claims (PVCs) in namespaces matching the
regex .\*ecs-am\*.
`sum by (namespace, persistentvolumeclaim)
(kubelet_volume_stats_used_bytes{namespace=~".\*ecs-am.\*"})`:
This metric `(kubelet_volume_stats_used_bytes)` represents
the amount of storage currently used by the PVCs.  The sum by
`(namespace, persistentvolumeclaim)` aggregates the used bytes
for each PVC, grouped by both the namespace and the PVC name.
The namespace=~".\*ecs-am\*." filter selects only those PVCs that are in
namespaces containing "\*ecs-am."
`sum by (namespace, persistentvolumeclaim) (kubelet_volume_stats_capacity_bytes{namespace=~".*ecs-am.*"})`:
This metric `(kubelet_volume_stats_capacity_bytes)` represents the total
capacity allocated for each PVC.  Similar to the previous sum, this
aggregates the total capacity for each PVC, also grouped by namespace
and PVC name, with the same namespace filter.
3. Division, Multiplication by 100:
The division of the two sums calculates the ratio of used storage to
total storage (capacity) for each PVC. This gives a value between 0 and 1,
representing how much of the allocated storage is currently being used.
The result of the division is multiplied by 100 to convert the ratio
into a percentage. This represents the utilization percentage of each PVC.

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
