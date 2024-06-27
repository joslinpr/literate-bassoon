# Accessing APIGEE PRG Clusters

## Apigee Bastion Host

``` bash
# Note that ans is not used -
$ swrap apigwaaa@czcholstc003532.prg-dc.dhl.com
 sw apigwaaa@czcholstc003532.prg-dc.dhl.com date
 Warning: Permanently added 'czcholstc003532.prg-dc.dhl.com,2.253.207.77' (ECDSA) to the list of known hosts.

                          * USAGE WARNING *
This  computer  system,  including  all equipment and
...

# apigwaaa is used only to access the node. User is apig.
$ sudo su - apig
Last login: Thu Feb 15 14:59:04 CET 2024 on pts/2

Value of TERM has been set to "tmux-256color".
Timeout is set to 300 seconds.

 ---- you are working on Virtual vmware server ----
```

<!-- vim: set noai noet nu cin sts=0 sw=3 ts=3 tw=0 filetype=markdown :-->
