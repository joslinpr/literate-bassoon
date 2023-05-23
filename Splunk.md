# Book of Knowledge
## Splunk.md
## Splunk Tricks
### Roles
What roles do I have?
```
| rest /services/authentication/current-context splunk_server=local | table title roles
```
### List Indices

To omit internal indices, remove `index=_*`.

```
| eventcount summarize=false index=* index=_* | dedup index | fields index
```

### List Sourcetype for each Index
```
| tstats count WHERE index=* OR sourcetype=* by index,sourcetype |
  stats values(sourcetype) AS sourcetypes by index
```
if you only need it from one index, use
```
| tstats count WHERE index=ecs-am-webv4 AND sourcetype=* by index,sourcetype |
  stats values(sourcetype) AS sourcetypes by index
```
### Count all pods used by ecs-am

[Dev Splunk](https://ocp-dev.splunk.dhl.com:8000/)
```
index="ecs_am_viewpoint" OR
index="ecs_am_webv4" OR
index="gbs_its_openshift_ecs-am-ramp" OR
index="gbs_its_openshift_ecs_am_viewpoint"
(sourcetype=*) (openshift_cluster=usqasocp001.dhl.com) (openshift_namespace = ecs-am-*) |
fields openshift_namespace, openshift_pod_name, sourcetype, _time |
eval pod_type=openshift_pod_name |
rex field=pod_type "s/-[a-z0-9]+[0-9].*$//" mode=sed |
stats distinct_count(openshift_pod_name) by openshift_namespace,pod_type
```

[Prod Splunk](https://splunk.dhl.com/)
```
index="gbs_its_openshift_ecs-am-ramp" OR
index="ecs_am_webv4" OR
index="gbs_its_openshift_ecs_am_viewpoint"
(sourcetype=*) (openshift_cluster=usqasocp001.dhl.com) (openshift_namespace = ecs-am-*) |
fields openshift_namespace, openshift_pod_name, sourcetype, _time |
eval pod_type=openshift_pod_name |
rex field=pod_type "s/-[a-z0-9]+[0-9].*$//" mode=sed |
stats distinct_count(openshift_pod_name) by openshift_namespace,pod_type
```

### Oldest and Newest Records
```
index="gbs_its_pds_infra_openshift_outcold"
(sourcetype=openshift_stats_v2_cgroup) |
stats earliest(_time) AS first, latest(_time) as last |
eval myfirst=strftime(first,"%Y-%m-%dT%H:%M:%S.%Q") |
eval mylast=strftime(last,"%m-%dT%H:%M:%S.%Q")
```
#### Same, for each sourcetype
```
index=gbs_its_openshift_ecs_am_viewpoint
(sourcetype=*) |
stats earliest(_time) AS first, latest(_time) as last by sourcetype |
eval myfirst=strftime(first,"%Y-%m-%dT%H:%M:%S.%Q"), mylast=strftime(last,"%m-%dT%H:%M:%S.%Q")`
```
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
