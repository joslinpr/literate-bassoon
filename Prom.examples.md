#	Book of Knowledge
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
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)