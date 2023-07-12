
##	Oracle.md
##	Oracle Tips and Tricks

###	Checking CRS
```
#	su - oracle              #	choose any DB
$ ps -fu oracle            #	Check for DBs
$ crsctl check crs         #	CRS daemons
$ crsctl check cluster
$ crsctl check css         #	cluster sync status
$ crsctl check evm         #	event manager
```
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
