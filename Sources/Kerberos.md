# The Book of Knowledge

## Kerberos Tips and Tricks

### Determining the KDCs (Kerberos Distribution Centers)

``` bash

nslookup -type=srv _kerberos._tcp.PRG-DC.DHL.COM

```

## Tracing Kerberos Traffic

You can run kinit with logging or track network traffic with tcpdump.  KDC
uses port 88.

``` bash

KRB5_TRACE=/dev/stdout kinit -V
Using principal: srv_expdac-icp@PRG-DC.DHL.COM
[995] 1690227514.959301: Getting initial credentials for
srv_expdac-icp@PRG-DC.DHL.COM
[995] 1690227515.60083: Sending unauthenticated request
[995] 1690227515.60084: Sending request (226 bytes) to PRG-DC.DHL.COM
[995] 1690227515.60085: Resolving hostname prg-dc.dhl.com
kinit: Cannot contact any KDC for realm 'PRG-DC.DHL.COM' while getting initial
credentials

```

## Using NMAP

Use nmap to check for port access.

``` bash

$ nmap -v -A --version-all -p88 kdc.domain.tld

```

## Debugging logins

KRB5_TRACE=/dev/stdout kinit -kt <_user_>.keytab <_user_>

``` bash

KRB5_TRACE=/dev/stdout kinit -kt <user>.keytab <user>

```

If you get the error message "kinit: clients credentials have been revoked while getting initial
credentials", try `kinit -V PRINCIPAL`.  If you still get the error, try
'kdestroy; kinit -V PRINCIPAL'.

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
