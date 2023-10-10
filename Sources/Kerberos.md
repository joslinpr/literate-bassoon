##	Kerberos Tips and Tricks

###	Determining the KDCs (Kerberos Distribution Centers)
```
nslookup -type=srv _kerberos._tcp.PRG-DC.DHL.COM
```

## Tracing Kerberos Traffic
You can run kinit with logging or track network traffic with tcpdump.  KDC
uses port 88.
```
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
```
$ nmap -v -A --version-all -p88 kdc.domain.tld
```
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
