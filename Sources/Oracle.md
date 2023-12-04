# The Book of Knowledge

---
title: "Oracle"
date: 2023-07-12T16:11:05-04:00
draft: false
TableOfContents: true
weight: 150
---

## Oracle Tips and Tricks

### Checking CRS

You must run the commands as user oracle.

``` bash

$ su - oracle              #    choose any DB
$ ps -fu oracle            #    Check for DBs
$ crsctl check crs         #    CRS daemons
$ crsctl check cluster
$ crsctl check css         #    cluster sync status
$ crsctl check evm         #    event manager

```

[//]: # ( vim: set ai noet nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
