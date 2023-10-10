
##	Prom.examples.md
##	Prometheus Query Examples

###	Infra Nodes
```
sort_desc(sum by (cpu,id,pod_name,container_name) (rate(container_cpu_usage_seconds_total{type="infra"}[5m])))
```

###	Number of containers by cluster and namespace without CPU limits

```
count by (namespace)(sum by (namespace,pod,container)(kube_pod_container_info{container!=""}) unless sum by (namespace,pod,container)(kube_pod_container_resource_limits{resource="cpu"})
```


###	Count of pods per cluster and namespace

```
sum by (namespace) (kube_pod_info)))
```

###	CPU USage per namespace

```
sort_desc(sum by (namespace) (rate(container_cpu_usage_seconds_total[5m])))
```

###	CPU overcommit

CPU limits over the capacity of the cluster is a scenario you need to avoid. Otherwise, you’ll end up with CPU throttling issues. You can detect CPU overcommit with the following query.

```
sum(kube_pod_container_resource_limits{resource="cpu"}) - sum(kube_node_status_capacity_cpu_cores)
```

### Kafka Disk Space Available
```
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
```
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
```
sum(rate(container_cpu_usage_seconds_total{container!=""}[5m])) by (pod)
```
The average number of CPU cores used during the last 5 minutes per each node:
```
sum(rate(container_cpu_usage_seconds_total{container!=""}[5m])) by (node)
```
The average number of CPU cores used during the last 5 minutes per each namespace:
```
sum(rate(container_cpu_usage_seconds_total{container!=""}[5m])) by (namespace)
```
The **container!=""** filter removes superfluous metrics related to cgroups hierarchy - see [this answer](https://stackoverflow.com/questions/69281327/why-container-memory-usage-is-doubled-in-cadvisor-metrics/69282328#69282328) for more details.
[Source](https://stackoverflow.com/questions/34923788/prometheus-convert-cpu-user-seconds-to-cpu-usage)

### Find Pods killed by OOM:
```
"kube_pod_container_status_last_terminated_reason{reason="OOMKilled"} >=1"
```
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
