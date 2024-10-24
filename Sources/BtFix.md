# Red Hat Bluetooth Tips & Tricks

## If Bluetooth Does Not Show Up In Settings App

``` bash

As root:

Ensure Bluetooth Is Available
# rfkill
ID TYPE      DEVICE      SOFT      HARD
 0 wlan      phy0   unblocked unblocked
 5 bluetooth hci0   unblocked unblocked
If bluetooth is shown as blocked
# rfkill unblock bluetooth

Check For Target Device
# bluetoothctl devices
Device FC:A8:9A:D2:BA:6C HK Onyx Studio 3

For Some Reason, You Have To Restart The Service Twice
# systemctl restart bluetooth.service
# systemctl restart bluetooth.service
# systemctl status bluetooth.service
● bluetooth.service - Bluetooth service
     Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled; preset: enabled)
     Active: active (running) since Thu 2024-10-24 08:59:35 EDT; 6s ago
       Docs: man:bluetoothd(8)
   Main PID: 1732846 (bluetoothd)
     Status: "Running"
      Tasks: 1 (limit: 99054)
     Memory: 832.0K
        CPU: 35ms
     CGroup: /system.slice/bluetooth.service
             └─1732846 /usr/libexec/bluetooth/bluetoothd

Oct 24 08:59:35 tmp5768 bluetoothd[1732846]: Endpoint registered: sender=:1.5192 path=/MediaEndpoint/A2DPSink/sbc
Oct 24 08:59:35 tmp5768 bluetoothd[1732846]: Endpoint registered: sender=:1.5192 path=/MediaEndpoint/A2DPSource/sbc
...

```
