
# DMZ Access Testing

- [DMZ Access Testing](#dmz-access-testing)
  - [No ELR, No Proxies Used](#no-elr-no-proxies-used)
    - [Internal Target](#internal-target)
    - [External Target](#external-target)
  - [Documentation](#documentation)
    - [Network connection between DMZ and internal Zone](#network-connection-between-dmz-and-internal-zone)
    - [Non-HTTP(S) Traffic](#non-https-traffic)

There have been questions about what access an application has from a
DMZ zone.  By default an application has **no** access to resources
outside the cluster.  This includes both internal (\*.dhl.com) and
external (the internet).

## No ELR, No Proxies Used

### Internal Target

``` bash

# curl -Lv https://whatismyip.dhl.com *Hangs "forever"*

*   Trying 2.253.218.60...
* TCP_NODELAY set
* connect to 2.253.218.60 port 443 failed: Connection timed out
* Failed to connect to whatismyip.dhl.com port 443: Connection timed out
* Closing connection 0
curl: (7) Failed to connect to whatismyip.dhl.com port 443: Connection timed out

```

With Proxy:

``` bash

# curl --proxy https://b2b-proxy.dhl.com:8080/  -Lv https://whatismyip.dhl.com/

* Could not resolve proxy: b2b-proxy.dhl.com
* Closing connection 0
curl: (5) Could not resolve proxy: b2b-proxy.dhl.com

```

### External Target

``` bash

# curl -Lv -ipv4 https://www.google.com/

*   Trying 142.250.185.228...
* TCP_NODELAY set
* connect to 142.250.185.228 port 443 failed: Connection timed out
* Failed to connect to www.google.com port 443: Connection timed out
* Closing connection 0
curl: (7) Failed to connect to www.google.com port 443: Connection timed out

I had to use -ipv4 because it was attempting to use ipv6 otherwise.

With Proxy:

# curl -Lv -ipv4 --proxy https://b2b-https.dhl.com:8080/ https://www.google.com/

* Could not resolve proxy: b2b-https.dhl.com
* Closing connection 0
curl: (5) Could not resolve proxy: b2b-https.dhl.com

# curl -Lv -ipv4 --proxy https://b2b-https.dhl.com:8080/ --dns-ipv4-addr 156.137.88.88 https://www.google.com/

curl: (4) A requested feature, protocol or option was not found built-in
   in this libcurl due to a build-time decision.

```

Adding the nameserver 156.137.88.88 to /etc/resolv.conf does not help, because the
   pod cannot reach the internal dns server.

## Documentation

### Network connection between DMZ and internal Zone

[Here](https://git.dhl.com/bimodal-coc/ITS-Container-Platform-Wiki/wiki/Network_Connections)

Generally intercluster communication between namespaces on v4 platforms
is possible. You can use ingress policies to white list traffic among
multiple namespaces and theirs services. Only constraint is projects /
namespaces **have to be within same net-zone** of the cluster. That means
Internal namespace vs Internal namespace or DMZ namespace vs DMZ
namespace. Refer to
[Inter project communication using network policy](https://git.dhl.com/bimodal-coc/ITS-Container-Platform-Wiki/wiki/Inter-project-communication-using-network-policy).

If you need to establish communication between DMZ namespaces and Internal
   Namespaces, you need to set up an ELR for Firewall:

In the case of DMZ --> Internal

- SOURCE: egress IP of DMZ namespace
- TARGET: IP of App Inbound (virtual IP of app VIP from F5).

Please set up a [VIP for Application Inbound
Traffic](https://git.dhl.com/bimodal-coc/ITS-Container-Platform-Wiki/wiki/Internet_Exposure)
and do not use OpenShift's platforms shared wildcard domains (for example
\*.test-int.apps.czchooct002.dhl.com). That would be a security risk,
because you can escape the DMZ into all wildcard destinations.

### Non-HTTP(S) Traffic

If you wish to pass non-HTTP(S) traffic, you will need an egress IP.  The
egress IP is used as the source IP for outbound traffic.  Creation Form is
[here](https://git.dhl.com/bimodal-coc/ITS-Container-Platform-Wiki/wiki/Egress).
Hints on connecting to Oracle Databases can be found
[here](https://git.dhl.com/bimodal-coc/ITS-Container-Platform-Wiki/wiki/Connecting_app_from_DMZ_to_Internal_Oracle_DB).
