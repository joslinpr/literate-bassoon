#	Book of Knowledge
##	ClusterList.md

###	Clusters
|Cluster | Node | Use | Link |
|---|---|---|---|
| czchoocp001 |  czcholspc004404 | PRG Prod V4    | [https://console.apps.czchoocp001.dhl.com](https://console.apps.czchoocp001.dhl.com) |
| czstlocp001 |  czstllspc005226 | PRG DR Prod V4 | [https://console.apps.czstlocp001.dhl.com](https://console.apps.czstlocp001.dhl.com) |
| mykulocp001 |  mykullspc005304 | CBJ Prod V4    | [https://console.apps.mykulocp001.dhl.com](https://console.apps.mykulocp001.dhl.com) |
| mytpmocp001 |  mytpmlspc005204 | CBJ DR V4      | [https://console.apps.mytpmocp001.dhl.com](https://console.apps.mytpmocp001.dhl.com) |
| usmegocp001 |  usmeglspc005204 | US Prod DR V4  | [https://console.apps.usmegocp001.dhl.com](https://console.apps.usmegocp001.dhl.com) |
| usqasocp001 |  usqaslspc005001 | US Prod V4     | [https://console.apps.usqasocp001.dhl.com](https://console.apps.usqasocp001.dhl.com) |
| czchooct001 |  czcholstc005204 | PRG Proof of Concept V4 | [https://console.apps.czchooct001.dhl.com](https://console.apps.czchooct001.dhl.com) |
| czchooct002 |  czcholstc005204 | PRG Test V4    | [https://console.apps.czchooct002.dhl.com](https://console.apps.czchooct002.dhl.com) |

###	Version 4
| Use  | Link |
|:--|:--|
| CBJ/DR V4   | [https://api.mytpmocp001.dhl.com:6443](https://api.mytpmocp001.dhl.com:6443 ) |
| CBJ V4      | [https://api.mykulocp001.dhl.com:6443](https://api.mykulocp001.dhl.com:6443 ) |
| Crash & Burn V4 | [https://api.czchooct999.dhl.com:6443](https://api.czchooct999.dhl.com:6443 ) |
| PRG/DR V4   | [https://api.czstlocp001.dhl.com:6443](https://api.czstlocp001.dhl.com:6443 ) |
| PRG/PRODV4 | [https://api.czchoocp001.dhl.com:6443](https://api.czchoocp001.dhl.com:6443 ) |
| PRG/TEST V4 | [https://api.czchooct002.dhl.com:6443](https://api.czchooct002.dhl.com:6443 ) |
| US/DR V4    | [https://api.usmegocp001.dhl.com:6443](https://api.usmegocp001.dhl.com:6443 ) |
| US V4       | [https://api.usqasocp001.dhl.com:6443](https://api.usqasocp001.dhl.com:6443 ) |

###	Version 3 (Decommissioned)
| Use  | Link |
|:--|:--|
| CBJ/DR      | [https://proddr2-ocp.kul-dc.dhl.com](https://proddr2-ocp.kul-dc.dhl.com ) |
| CBJ/PROD    | [https://prod2-ocp.kul-dc.dhl.com](https://prod2-ocp.kul-dc.dhl.com ) |
| Crash & Burn V3 | [https://prod1-ocp-cb.prg-dc.dhl.com/console](https://prod1-ocp-cb.prg-dc.dhl.com/console ) |
| PRG/DR      | [https://proddr1-ocp.prg-dc.dhl.com](https://proddr1-ocp.prg-dc.dhl.com ) |
| PRG/PROD    | [https://prod1-ocp.prg-dc.dhl.com](https://prod1-ocp.prg-dc.dhl.com ) |
| US/PROD     | [https://prod3-ocp.phx-dc.dhl.com](https://prod3-ocp.phx-dc.dhl.com ) |

###	Example:
```
oc login --token=sha256~qYB9ZtYrp0sqYUMNL_M4cjnA_35_uDy02ZYeMGnt02w --server=https://api.czchooct001:6443
oc whoami
      --show-console=false: If true, print the current server's web console URL
  -c, --show-context=false: Print the current user context name
      --show-server=false: If true, print the current server's REST API URL
  -t, --show-token=false: Print the token the current session is using. This will return an error if you are using a
different form of authentication.
```

###	Utility Nodes
| Cluster | Name | Use |
|:--|:--|:--|
| None | czcholspc002815 | Kafka Support, podman |
| czchoocp001 |  czcholspc004404 | PRG Prod V4    |
| czstlocp001 |  czstllspc005226 | PRG DR Prod V4 |
| mykulocp001 |  mykullspc005304 | CBJ Prod V4    |
| mytpmocp001 |  mytpmlspc005204 | CBJ DR V4      |
| usmegocp001 |  usmeglspc005204 | US Prod DR V4  |
| usqasocp001 |  usqaslspc005001 | US Prod V4     |
| czchooct001 |  czcholstc005204 | PRG Proof of Concept V4 |
| czchooct002 |  czcholstc005204 | PRG Test V4    |


[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
