# The Book of Knowledge

## US OpenShift Container Platform Networking


### Ingress Ranges

| Cluster |Network  | Ingress Ranges                     |
|-------|---------|---------------------------------|
| USQAS |Prod-int | usqaslspc005325 usqaslspc005326 |
| USQAS |Test-int | usqaslspc005625 usqaslspc005626 |
| USQAS |Prod-dmz | usqaslspc005440 usqaslspc005441 |
| USQAS |Test-dmz | usqaslspc005740 usqaslspc005741 |
| USQAS |---------|---------------------------------|

usmeglspc005225.phx-dc.dhl.com | 7.245.22.12
usmeglspc005226.phx-dc.dhl.com | 7.245.22.13
usmeglspc005283.phx-dc.dhl.com | 156.137.229.12
usmeglspc005284.phx-dc.dhl.com | 156.137.229.13
usqaslspc005325.phx-dc.dhl.com | 7.244.168.12
usqaslspc005326.phx-dc.dhl.com | 7.244.168.13
usqaslspc005440.phx-dc.dhl.com | 156.137.125.12
usqaslspc005441.phx-dc.dhl.com | 156.137.125.13
usqaslspc005625.phx-dc.dhl.com | 156.137.93.12
usqaslspc005626.phx-dc.dhl.com | 156.137.93.13
usqaslspc005740.phx-dc.dhl.com | 156.137.124.12
usqaslspc005741.phx-dc.dhl.com | 156.137.124.13

### Ingress Networks in the US

Network  | USQASCOP001                     | USMEGOCP001
---------|---------------------------------|-----------------------------------
Prod-int | usqaslspc005325 usqaslspc005326 | usmeglspc005225 usmeglspc005226
---------|---------------------------------|-----------------------------------
Test-int | usqaslspc005625 usqaslspc005626 |
---------|---------------------------------|-----------------------------------
Prod-dmz | usqaslspc005440 usqaslspc005441 | usmeglspc005283 usmeglspc005284
---------|---------------------------------|-----------------------------------
Test-dmz | usqaslspc005740 usqaslspc005741 |
---------|---------------------------------|-----------------------------------
## Egress Ranges

| Cluster | Stage                      | Egress Ranges             |
|---------|----------------------------|---------------------------|
| USQAS   | Test Egress Internal       | Subnet 156.137.93.128/25  |
| USQAS   | Test Egress DMZ            | Subnet 156.137.124.128/25 |
| USQAS   | Production Egress Internal | Subnet 7.244.168.128/25   |
| USQAS   | Production Egress DMZ      | Subnet 156.137.125.128/25 |
| USMEG   | Production Egress Internal | Subnet 7.245.22.128/25    |
| USMEG   | Production Egress DMZ      | Subnet 156.137.229.128/25 |

## Egress Routers

### [US Prod and Test v4 Openshift cluster](https://console.apps.usqasocp001.dhl.com)

| prod-int.apps.usqasocp001.dhl.com | net-zone      | IP           |
|-----------------------------------|---------------|--------------|
| usqaslspc005327.phx-dc.dhl.com    | prod-internal | 7.244.168.14 |
| usqaslspc005326.phx-dc.dhl.com    | prod-internal | 7.244.168.13 |
| usqaslspc005325.phx-dc.dhl.com    | prod-internal | 7.244.168.12 |

| prod-dmz.apps.usqasocp001.dhl.com | net-zone | IP             |
|-----------------------------------|----------|----------------|
| usqaslspc005441.phx-dc.dhl.com    | prod-dmz | 156.137.125.13 |
| usqaslspc005440.phx-dc.dhl.com    | prod-dmz | 156.137.125.12 |

| test-int.apps.usqasocp001.dhl.com | net-zone      | IP            |
|-----------------------------------|---------------|---------------|
| usqaslspc005627.phx-dc.dhl.com    | test-internal | 156.137.93.14 |
| usqaslspc005626.phx-dc.dhl.com    | test-internal | 156.137.93.13 |
| usqaslspc005625.phx-dc.dhl.com    | test-internal | 156.137.93.12 |

| test-dmz.apps.usqasocp001.dhl.com | net-zone | IP             |
|-----------------------------------|----------|----------------|
| usqaslspc005741.phx-dc.dhl.com    | test-dmz | 156.137.124.13 |
| usqaslspc005740.phx-dc.dhl.com    | test-dmz | 156.137.124.12 |

### [US Test v4 Openshift cluster](https://console.apps.usqasoct002.dhl.com)

| test-int.apps.usqasocp001.dhl.com | net-zone      | IP            |
|-----------------------------------|---------------|---------------|
| usqaslspc005627.phx-dc.dhl.com    | test-internal | 156.137.93.14 |
| usqaslspc005626.phx-dc.dhl.com    | test-internal | 156.137.93.13 |
| usqaslspc005625.phx-dc.dhl.com    | test-internal | 156.137.93.12 |

| test-dmz.apps.usqasocp001.dhl.com | net-zone | IP             |
|-----------------------------------|----------|----------------|
| usqaslspc005754.phx-dc.dhl.com    | test-dmz | 156.137.124.26 |
| usqaslspc005753.phx-dc.dhl.com    | test-dmz | 156.137.124.25 |

### [US DR v4 Openshift cluster](https://console.apps.usmegocp001.dhl.com)

| prod-int.apps.usmegocp001.dhl.com | net-zone      | IP          |
|-----------------------------------|---------------|-------------|
| usmeglspc005227.phx-dc.dhl.com    | prod-internal | 7.245.22.14 |
| usmeglspc005226.phx-dc.dhl.com    | prod-internal | 7.245.22.13 |
| usmeglspc005225.phx-dc.dhl.com    | prod-internal | 7.245.22.12 |

| prod-dmz.apps.usmegocp001.dhl.com | net-zone | IP             |
|-----------------------------------|----------|----------------|
| usmeglspc005284.phx-dc.dhl.com    | prod-dmz | 156.137.229.13 |
| usmeglspc005283.phx-dc.dhl.com    | prod-dmz | 156.137.229.12 |

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
