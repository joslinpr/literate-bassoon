
# The Book of Knowledge

- [Production Egress Internal](#production-egress-internal)
  - [Egress Routers Prod Internal](#egress-routers-prod-internal)
  - [Egress IPs Prod Internal](#egress-ips-prod-internal)
- [Production Egress DMZ](#production-egress-dmz)
  - [Egress Routers Prod DMZ](#egress-routers-prod-dmz)
  - [Egress IPs Prod DMZ](#egress-ips-prod-dmz)
- [Test Egress Internal](#test-egress-internal)
  - [Egress Routers Test Internal](#egress-routers-test-internal)
  - [Egress IPs Test Internal](#egress-ips-test-internal)
- [Test Egress DMZ](#test-egress-dmz)
  - [Egress Routers Test DMZ](#egress-routers-test-dmz)
  - [Egress IPs Test DMZ](#egress-ips-test-dmz)

## Production Egress Internal

Subnet 7.244.168.128/25

### Egress Routers Prod Internal

|Router IP             | Router hostname     |
| -----                | ------            |
|  7.244.168.140    | usqaslspc005555     |
|  7.244.168.141    | usqaslspc005556     |

### Egress IPs Prod Internal

|Egress IP             | Namespace          |
| -----                | ------            |
| 7.244.168.148        | ecs-am-ramp-webapps-sbx |
| 7.244.168.149        | ecs-am-ramp-webapps-prd |
| 7.244.168.150        | its-cicd-endtoend-monitoring-prod |
| 7.244.168.151        | dsc-edoc-us-prod |
| 7.244.168.152        | dsc-score-us-prod |
| 7.244.168.153        | dsc-theview-us-prod |
| 7.244.168.154        | dsc-util-us-prod |
| 7.244.168.155        | its-jenkins-prod |
| 7.244.168.156        | exp-lt1-qas-prod |
| 7.244.168.157        | dsc-svt-robotics-us-prod |
| 7.244.168.158        | ecs-am-devops-prd |
| 7.244.168.159        | ecs-am-monitoring-prod |
| -                 |                    |
| 7.244.168.254        | __LAST IP__         |

## Production Egress DMZ

Subnet 156.137.125.128/25

### Egress Routers Prod DMZ

|Router IP             | Router hostname     |
| -----                | ------            |
| 156.137.125.140    | usqaslspc005563     |
| 156.137.125.141    | usqaslspc005564     |

### Egress IPs Prod DMZ

|Egress IP             | Namespace          |
| -----                | ------            |
| 156.137.125.148    | ecs-am-ramp-webapps-dmz-prod    |
| 156.137.125.149    |    dsc-svt-robotics-us-dmz-prod  |
| 156.137.125.150    | its-cicd-endtoend-monitoring-dmz-prod |
| 156.137.125.151    | dsc-edoc-us-dmz-prod |
| 156.137.125.152    | dsc-score-us-dmz-prod |
| 156.137.125.153    | dsc-theview-us-dmz-prod |
| 156.137.125.154    | dsc-util-us-dmz-prod |
| 156.137.125.155    | dsc-idea-dmz-prod |
| 156.137.125.156    | exp-cra-prod-dmz |
| 156.137.125.157    | dsc-mysupplychain-dmz-prod |
| -                 |                    |
| 156.137.125.254    | __LAST IP__         |

## Test Egress Internal

Subnet 156.137.93.128/25

### Egress Routers Test Internal

|Router IP             | Router hostname     |
| -----                | ------            |
| 156.137.93.140    | usqaslspc005855     |
| 156.137.93.141    | usqaslspc005856     |

### Egress IPs Test Internal

|Egress IP             | Namespace          |
| -----                | ------            |
| 156.137.93.148    | __FIRST IP__        |
| 156.137.93.149    |    dsc-theview-us-dev |
| 156.137.93.150    | its-cicd-endtoend-monitoring-test |
| 156.137.93.151    | ecs-am-ramp-webapps-dev |
| 156.137.93.152    | ecs-am-ramp-webapps-sit |
| 156.137.93.153    | ecs-am-ramp-webapps-bat |
| 156.137.93.154    | dsc-edoc-us-test |
| 156.137.93.155    | dsc-score-us-test |
| 156.137.93.156    | dsc-theview-us-test |
| 156.137.93.157    | dsc-util-us-test |
| 156.137.93.158    | dsc-idea-fat |
| 156.137.93.159    | dgf-edm-test |
| 156.137.93.160    | dgf-edm-dev  |
| 156.137.93.161    | dgf-edm-oc-dev |
| 156.137.93.162    | dgf-edm-oc-uat |
| 156.137.93.163  |    dsc-svt-robotics-us-test |
| 156.137.93.164  |    ecs-am-devops-dev |
| 156.137.93.165  |    ecs-am-ramp-quality |
| 156.137.93.166  |    ecs-am-monitoring-test|
| 156.137.93.167  | free|
| 156.137.93.168  |    free|
| 156.137.93.169  |    free |
| -                 |                    |
| 156.137.93.254    | __LAST IP__         |

## Test Egress DMZ

Subnet 156.137.124.128/25

### Egress Routers Test DMZ

|Router IP             | Router hostname     |
| -----                | ------            |
| 156.137.124.140    | usqaslspc005863     |
| 156.137.124.141    | usqaslspc005864     |

### Egress IPs Test DMZ

|Egress IP             | Namespace          |
| -----                | ------            |
| 156.137.124.148    | ecs-am-ramp-webapps-dmz-test |
| 156.137.124.149 |dsc-mysupplychain-dmz-uat|
| 156.137.124.150    | its-cicd-endtoend-monitoring-dmz-prod |
| 156.137.124.151    | dsc-svt-robotics-us-dmz-test |
| 156.137.124.152    | free |
| 156.137.124.153    | free |
| -                 |                    |
| -                 |                    |
| 156.137.124.154    | dsc-edoc-us-dmz-test |
| 156.137.124.155    | dsc-score-us-dmz-test |
| 156.137.124.156    | dsc-theview-us-dmz-test |
| 156.137.124.157    | dsc-util-us-dmz-test |
| 156.137.124.158    | dsc-idea-dmz-uat |
| 156.137.124.159    | exp-cra-test-dmz |
| 156.137.124.160    | exp-cra-dev-dmz |
| 156.137.124.161    | exp-cra-dmz-test-2 |
| 156.137.124.162    | exp-cra-dmz-build |
| -                 |                    |
| 156.137.124.254    | __LAST IP__         |
[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=100 filetype=markdown :)
