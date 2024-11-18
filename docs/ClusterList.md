# Book of Knowledge

## OpenShift Clusters at DHL

### Clusters

### Version 4

|Name          | URL                                  | Use                    |
|--------------|--------------------------------------|------------------------|
| CBJ_DR       | [https://api.mytpmocp001.dhl.com:6443](https://api.mytpmocp001.dhl.com:6443) | CBJ Disaster Recovery  |
| CBJ_PROD     | [https://api.mykulocp001.dhl.com:6443](https://api.mykulocp001.dhl.com:6443) | CBJ Production         |
|              |                                      |POC                     |
| PRG_APG_CBJ  | [https://api.mykulocp002.dhl.com:6443](https://api.mykulocp002.dhl.com:6443) | Apigee Express CBJ Prod |
| PRG_APG_PROD | [https://api.czchoocp002.dhl.com:6443](https://api.czchoocp002.dhl.com:6443) | Apigee - Express PRG Production |
| PRG_APG_TEST | [https://api.czchooct004.dhl.com:6443](https://api.czchooct004.dhl.com:6443) | Apigee - Express PRG Test|
| PRG_API_PROD | [https://api.czchoocp003.dhl.com:6443](https://api.czchoocp003.dhl.com:6443) | ITS Api PRG Production |
| PRG_BMC      | [https://api.czchooct201.dhl.com:6443](https://api.czchooct201.dhl.com:6443) | PRG Bare Metal POC     |
| PRG_CNB      | [https://api.czchooct999.dhl.com:6443](https://api.czchooct999.dhl.com:6443) | PRG Crash and Burn     |
| PRG_DED_POC  | [https://api.czchooct888.dhl.com:6443](https://api.czchooct888.dhl.com:6443) | PRG Dedicated Clusters |
| PRG_DR       | [https://api.czstlocp001.dhl.com:6443](https://api.czstlocp001.dhl.com:6443) | PRG Disaster Recovery  |
| PRG_MQ_DR    | [https://api.czstlocp002.dhl.com:6443](https://api.czstlocp002.dhl.com:6443) | PRG DR ITS IBM MQ      |
| PRG_MQ_PROD  | [https://api.czchoocp004.dhl.com:6443](https://api.czchoocp004.dhl.com:6443) | ITS IBM MQ PRG Production|
| PRG_MQ_TEST  | [https://api.czchooct005.dhl.com:6443](https://api.czchooct005.dhl.com:6443) | ITS IBM MQ PRG Test    |
| PRG_POC      | [https://api.czchooct001.dhl.com:6443](https://api.czchooct001.dhl.com:6443) | PRG Proof of Concept   |
| PRG_PROD     | [https://api.czchoocp001.dhl.com:6443](https://api.czchoocp001.dhl.com:6443) | PRG Production         |
| PRG_REPO_DR  | [https://api.czstlocp001.dhl.com:6443](https://api.czstlocp001.dhl.com:6443) | PRG DR Repository      |
| PRG_TEST     | [https://api.czchooct002.dhl.com:6443](https://api.czchooct002.dhl.com:6443) | PRG Test               |
| US_DR        | [https://api.usmegocp001.dhl.com:6443](https://api.usmegocp001.dhl.com:6443) | US Disaster Recovery   |
| US_EDM_PROD  | [https://api.usqasocp002.dhl.com:6443](https://api.usqasocp002.dhl.com:6443) | US EDM Dedicated Production |
| US_EDM_TEST  | [https://api.usqasoct003.dhl.com:6443](https://api.usqasoct003.dhl.com:6443) | US EDM Dedicated Test  |
| US_PROD      | [https://api.usqasocp001.dhl.com:6443](https://api.usqasocp001.dhl.com:6443) | US Production          |
| US_TEST      | [https://api.usqasoct002.dhl.com:6443](https://api.usqasoct002.dhl.com:6443) | US Test                |

### Example

``` bash

oc login --token=sha256~qYB9ZtYrp0sqYUMNL_M4cjnA_35_uDy02ZYeMGnt02w --server=https://api.czchooct001:6443
oc whoami
      --show-console=false: If true, print the current server's web console URL
  -c, --show-context=false: Print the current user context name
      --show-server=false: If true, print the current server's REST API URL
  -t, --show-token=false: Print the token the current session is
  using. This will return an error if you are using a different form of authentication.

```

### Utility Nodes

| Cluster     | User | Host                           |
|-------------|------|--------------------------------|
| CBJ_DR      | ans  | mytpmlspc005204.apis.dhl.com   |
| CBJ_PROD    | ans  | mykullspc005304.apis.dhl.com   |
| PRG_CNB     | ans  | czcholstc005504.prg-dc.dhl.com |
| PRG_DR      | ans  | czstllspc005204.prg-dc.dhl.com |
| PRG_POC     | ans  | czcholstc005041.prg-dc.dhl.com |
| PRG_PROD    | ans  | czcholspc004404.prg-dc.dhl.com |
| PRG_TEST    | ans  | czcholstc005204.prg-dc.dhl.com |
| US_DR       | ans  | usmeglspc005204.phx-dc.dhl.com |
| US_EDM_PROD | ans  | usqaslspc005871.phx-dc.dhl.com |
| US_EDM_TEST | ans  | usqaslspc005871.phx-dc.dhl.com |
| US_PROD     | ans  | usqaslspc005304.phx-dc.dhl.com |
| US_TEST     | ans  | usqaslspc005304.phx-dc.dhl.com |
| None        | None | czcholspc002815 Kafka Support  |

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
