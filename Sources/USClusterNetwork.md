# 1. US VIPS

- [1. US VIPS](#1-us-vips)
  - [1.1. Standard Egress](#11-standard-egress)
  - [1.2. Standard Ingress](#12-standard-ingress)
  - [1.3. Non-Existent Environments](#13-non-existent-environments)
  - [1.4. Egress Exceptions - EgressIPs](#14-egress-exceptions---egressips)
    - [1.4.1. USQASOCP001 Egress IPs Prod Internal](#141-usqasocp001-egress-ips-prod-internal)
    - [1.4.2. USQASOCP001 Egress IPs Prod DMZ](#142-usqasocp001-egress-ips-prod-dmz)
    - [1.4.3. USQASOCP001 / USQASOCT002 Egress IPs Test Internal](#143-usqasocp001--usqasoct002-egress-ips-test-internal)
    - [1.4.4. USMEGOCP001 Egress IPs Prod Internal](#144-usmegocp001-egress-ips-prod-internal)
    - [1.4.5. USMEGOCP001 Egress IPs Prod DMZ](#145-usmegocp001-egress-ips-prod-dmz)

## 1.1. Standard Egress

| Cluster     | Network  | Stage | Egress Subnet      | Egress Routers                  |
|-------------|----------|-------|--------------------|---------------------------------|
| USQASOCT002 | INTERNAL | Test  | 156.137.93.128/25  | 156.137.93.140 156.137.93.141   |
| USQASOCT002 | DMZ      | Test  | 156.137.124.128/25 |                                 |
| USQASOCP001 | INTERNAL | Test  | 156.137.93.128/25  | 156.137.93.140 156.137.93.141   |
| USQASOCP001 | INTERNAL | Prod  | Egress             |                                 |
| USQASOCP001 | DMZ      | Test  | 156.137.124.128/25 |                                 |
| USQASOCP001 | DMZ      | Prod  | 156.137.125.128/25 | 156.137.125.140 156.137.125.141 |
| USMEGOCP001 | INTERNAL | Prod  | 7.244.168.128/25   | 7.244.168.140 7.244.168.141     |
| USMEGOCP001 | DMZ      | Prod  | 156.137.229.0/25   |                                 |

## 1.2. Standard Ingress

| Cluster     | Network  | Stage | Ingress Routers   |
|-------------|----------|-------|-------------------|
| USQASOCT002 | INTERNAL | Test  | 156.137.93.4[678] |
| USQASOCT002 | DMZ      | Test  | 156.137.124.2[56] |
| USQASOCP001 | INTERNAL | Test  | 156.137.93.1[234] |
| USQASOCP001 | INTERNAL | Prod  | 7.244.168.1[234]  |
| USQASOCP001 | DMZ      | Test  | 156.137.124.1[23] |
| USQASOCP001 | DMZ      | Prod  | 156.137.125.1[23] |
| USMEGOCP001 | INTERNAL | Prod  | 7.245.22.1[234]   |

## 1.3. Non-Existent Environments

There is no Test in USMEGOCP001, and no Prod in USQASOCT002.

| Cluster     | Network  | Stage | Egress Subnet | Egress Routers |
|-------------|----------|-------|---------------|----------------|
| USQASOCT002 | INTERNAL | Prod  | NONE          | NONE           |
| USQASOCT002 | DMZ      | Prod  | NONE          | NONE           |
| USMEGOCP001 | INTERNAL | Test  | NONE          | NONE           |
| USMEGOCP001 | DMZ      | Test  | NONE          | NONE           |

## 1.4. Egress Exceptions - EgressIPs

### 1.4.1. USQASOCP001 Egress IPs Prod Internal

| Egress IP     | Namespace                            |
|---------------|--------------------------------------|
| 7.244.168.161 | its-jenkins-cloudbees-sandboxes-prod |
| 7.244.168.160 | its-jenkins-masters-prod             |
| 7.244.168.159 | Available for Reuse                  |
| 7.244.168.158 | ecs-am-devops-prd                    |
| 7.244.168.157 | ecs-loop-am-prod-env (INC62790584)   |
| 7.244.168.156 | exp-lt1-qas-prod                     |
| 7.244.168.155 | its-jenkins-prod                     |
| 7.244.168.154 | dsc-util-us-prod                     |
| 7.244.168.153 | dsc-theview-us-prod                  |
| 7.244.168.152 | dsc-score-us-prod                    |
| 7.244.168.151 | dsc-edoc-us-prod                     |
| 7.244.168.150 | its-cicd-endtoend-monitoring-prod    |
| 7.244.168.149 | ecs-am-ramp-webapps-prd              |
| 7.244.168.148 | ecs-am-ramp-webapps-sbx              |

### 1.4.2. USQASOCP001 Egress IPs Prod DMZ

| Egress IP       | Namespace                             |
|-----------------|---------------------------------------|
| 156.137.125.161 | ecs-am-ramp-dmz-webapps-ext-sbx       |
| 156.137.125.160 | ecs-am-ramp-dmz-webapps-ext-prd       |
| 156.137.125.159 | its-demp-dmz-prod INC60936776         |
| 156.137.125.158 | exp-cra-dmz-prod-2                    |
| 156.137.125.157 | dsc-mysupplychain-dmz-prod            |
| 156.137.125.156 | exp-cra-prod-dmz                      |
| 156.137.125.155 | dsc-idea-dmz-prod                     |
| 156.137.125.154 | dsc-util-us-dmz-prod                  |
| 156.137.125.153 | dsc-theview-us-dmz-prod               |
| 156.137.125.152 | dsc-score-us-dmz-prod                 |
| 156.137.125.151 | dsc-edoc-us-dmz-prod                  |
| 156.137.125.150 | its-cicd-endtoend-monitoring-dmz-prod |
| 156.137.125.148 | ecs-am-ramp-webapps-dmz-prod          |

### 1.4.3. USQASOCP001 / USQASOCT002 Egress IPs Test Internal

| Egress IP      | Namespace                                  |
|----------------|--------------------------------------------|
| 156.137.93.149 | dsc-theview-us-dev                         |
| 156.137.93.150 | its-cicd-endtoend-monitoring-test          |
| 156.137.93.151 | ecs-am-ramp-webapps-dev                    |
| 156.137.93.152 | ecs-am-ramp-webapps-sit                    |
| 156.137.93.153 | ecs-am-ramp-webapps-bat                    |
| 156.137.93.154 | dsc-edoc-us-test                           |
| 156.137.93.155 | dsc-score-us-test                          |
| 156.137.93.156 | dsc-theview-us-test                        |
| 156.137.93.157 | dsc-util-us-test                           |
| 156.137.93.158 | dsc-idea-fat                               |
| 156.137.93.159 | dgf-edm-test                               |
| 156.137.93.160 | dgf-edm-dev                                |
| 156.137.93.161 | dgf-edm-oc-dev                             |
| 156.137.93.162 | dgf-edm-oc-uat                             |
| 156.137.93.163 | exp-sfa-exp-test-find-my-rep (USQASOCT002) |
| 156.137.93.164 | ecs-am-devops-dev                          |
| 156.137.93.165 | ecs-am-ramp-quality                        |
| 156.137.93.167 | cluster-operations (USQASOCT002)           |

### 1.4.4. USMEGOCP001 Egress IPs Prod Internal

| Egress IP    | namespace                         |
|--------------|-----------------------------------|
| 7.245.22.159 | ecs-am-ramp-webapps-sit           |
| 7.245.22.158 | ecs-am-ramp-webapps-dev           |
| 7.245.22.157 | ecs-am-ramp-webapps-bat           |
| 7.245.22.155 | exp-lt1-meg-prod                  |
| 7.245.22.154 | dsc-util-us-prod                  |
| 7.245.22.153 | dsc-theview-us-prod               |
| 7.245.22.152 | dsc-edoc-us-prod                  |
| 7.245.22.151 | dsc-score-us-prod                 |
| 7.245.22.150 | its-cicd-endtoend-monitoring-prod |
| 7.245.22.149 | ecs-am-ramp-webapps-prd           |
| 7.245.22.148 | ecs-am-ramp-webapps-sbx           |

### 1.4.5. USMEGOCP001 Egress IPs Prod DMZ

| Egress IP       | namespace                             |
|-----------------|---------------------------------------|
| 156.137.229.157 | ecs-am-ramp-dmz-webapps-ext-prd       |
| 156.137.229.156 | ecs-am-ramp-dmz-webapps-ext-bat       |
| 156.137.229.155 | ecs-am-ramp-dmz-webapps-ext-dev       |
| 156.137.229.154 | dsc-util-us-dmz-prod                  |
| 156.137.229.153 | dsc-theview-us-dmz-prod               |
| 156.137.229.152 | dsc-edoc-us-dmz-prod                  |
| 156.137.229.151 | dsc-score-us-dmz-prod                 |
| 156.137.229.150 | its-cicd-endtoend-monitoring-dmz-prod |
| 156.137.229.148 | ecs-am-ramp-webapps-dmz-prod          |
