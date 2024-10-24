# The Book of Knowledge

   * [FC_Troubleshooting.md](#fc_troubleshootingmd)
   * [Fibre Channel Troubleshooting](#fibre-channel-troubleshooting)
      + [Check the existence and status of the fibre cards: lspci | grep -i qlogic](#check-the-existence-and-status-of-the-fibre-cards-lspci--grep--i-qlogic)
         - [Three Ways to Check the status of the fibre cards](#three-ways-to-check-the-status-of-the-fibre-cards)
         - [Check the existence of the LUN devices](#check-the-existence-of-the-lun-devices)
         - [Check if the number of LUNs is the same in all fibre card links](#check-if-the-number-of-luns-is-the-same-in-all-fibre-card-links)
         - [To identify and to locate the WWPN numbers of the installed fibre cards](#to-identify-and-to-locate-the-wwpn-numbers-of-the-installed-fibre-cards)
         - [Check if the SCLI (SANsurfer FC HBA CLI) package is installed in the o/s](#check-if-the-scli-sansurfer-fc-hba-cli-package-is-installed-in-the-os)
         - [Check the status of the fibre cards](#check-the-status-of-the-fibre-cards)
         - [Check the modprobe configuration for qla2xxx module](#check-the-modprobe-configuration-for-qla2xxx-module)

## FC_Troubleshooting.md

## Fibre Channel Troubleshooting

### Check the existence and status of the fibre cards: lspci | grep -i qlogic

#### Three Ways to Check the status of the fibre cards

``` bash

systool -c scsi_host -v |egrep -i 'fw_state|link'
/opt/hp/hp_fibreutils/adapter_info
egrep -i "link|run" /sys/class/scsi_host/host?/state

```

#### Check the existence of the LUN devices

``` bash

/usr/sbin/inq -btl -no_dots

```

#### Check if the number of LUNs is the same in all fibre card links

``` bash

lsscsi -g #    (Optional by installing the lsscsi rpm package)

```

#### To identify and to locate the WWPN numbers of the installed fibre cards

``` bash

for n in `ls -lrt /sys/class/fc_host/host[0-9]*/port_name|awk '{print $9}'|cut -d/ -f5`;
  do
    p=`cat /sys/class/fc_host/$n/port_name`; printf "$n - $p\n";
  done

```

#### Check if the SCLI (SANsurfer FC HBA CLI) package is installed in the o/s

``` bash

yum list scli*

```

#### Check the status of the fibre cards

``` bash

systool -c scsi_host -v |egrep -i 'fw_state|link'

```

#### Check the modprobe configuration for qla2xxx module

``` bash

/etc/modprobe.conf or /etc/modprobe.d/qla2xxx.conf

```

should contain this line

``` bash

install qla2xxx { /sbin/modprobe hpsa; } ; /sbin/modprobe --first-time --ignore-install qla2xxx options qla2xxx ql2xmaxqdepth=64 qlport_down_retry=64 ql2xloginretrycount=16 ql2xextended_error_logging=1

```

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
