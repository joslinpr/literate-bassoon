
# The Book of Knowledge

* [The Book of Knowledge](#the-book-of-knowledge)
  * [Roles](#roles)
  * [List Indices](#list-indices)
  * [List Sourcetype for each Index](#list-sourcetype-for-each-index)
  * [Count all pods used by ecs-am](#count-all-pods-used-by-ecs-am)
  * [Count all pods used by ecs-am, same, but namespace contains "SIT"](#count-all-pods-used-by-ecs-am-same-but-namespace-contains-sit)
  * [Oldest and Newest Records](#oldest-and-newest-records)
  * [Same, for each sourcetype](#same-for-each-sourcetype)

## Splunk.md

## Splunk Tricks

### Roles

  What roles do I have?

  ``` bash

  | rest /services/authentication/current-context splunk_server=local | table title roles

  ```

### List Indices

  To omit internal indices, remove `index=_*`.

  ``` bash

  | eventcount summarize=false index=* index=_* | dedup index | fields index
# To limit the output to a pattern:
  | eventcount summarize=false index=* index=_* | dedup index | fields index | where like(index,"%ecs%")
  ```

### List Sourcetype for each Index

  ``` bash

  | tstats count WHERE index=* OR sourcetype=* by index,sourcetype |
  stats values(sourcetype) AS sourcetypes by index

  ```

  if you only need it from one index, use

  ``` bash

  | tstats count WHERE index=ecs_am_webv4 AND sourcetype=* by index,sourcetype |
  stats values(sourcetype) AS sourcetypes by index

  ```

### Count all pods used by ecs-am

  [Dev Splunk](https://ocp-dev.splunk.dhl.com:8000/)

  ``` bash

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

### Count all pods used by ecs-am, same, but namespace contains "SIT"

  ``` bash
# Notice the rex to strip the generated parts of the pod name.

  index="gbs_its_openshift_ecs-am-ramp" OR
  index="gbs_its_openshift_ecs_am_viewpoint" OR
  index="ecs_am_webv4"
(sourcetype=*) (openshift_cluster=usqasoct002.dhl.com) (openshift_namespace = ecs-am-*sit*)
  | fields openshift_namespace, openshift_pod_name, index, sourcetype, _time
  | eval pod_type=openshift_pod_name
  | rex field=pod_type "s/-[a-z0-9]+[0-9].*$//" mode=sed
  | stats distinct_count(openshift_pod_name) by
  index,openshift_namespace,pod_type

  ```

  [Prod Splunk](https://splunk.dhl.com/)

  ``` bash

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

  ``` bash

  index="gbs_its_pds_infra_openshift_outcold"
  (sourcetype=openshift_stats_v2_cgroup) |
  stats earliest(_time) AS first, latest(_time) as last |
  eval myfirst=strftime(first,"%Y-%m-%dT%H:%M:%S.%Q") |
  eval mylast=strftime(last,"%m-%dT%H:%M:%S.%Q")

  ```

#### Same, for each sourcetype

  ``` bash

  index=gbs_its_openshift_ecs_am_viewpoint
  (sourcetype=*) |
  stats earliest(_time) AS first, latest(_time) as last by sourcetype |
  eval myfirst=strftime(first,"%Y-%m-%dT%H:%M:%S.%Q"), mylast=strftime(last,"%m-%dT%H:%M:%S.%Q")`

  ```

  [//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
