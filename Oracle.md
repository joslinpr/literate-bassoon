#      Book of Knowledge

## Oracle Tips and Tricks
### Checking CRS
```
## su - oracle              # choose any DB
$ ps -fu oracle            # Check for DBs
$ crsctl check crs         # CRS daemons
$ crsctl check cluster
$ crsctl check css         # cluster sync status
$ crsctl check evm         # event manager
```
