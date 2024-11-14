
# The Book of Knowledge

## OMC

`omc` tool has been created to allow engineers to inspect resources from a must-gather in the same way as they are retrieved with the oc command.

[Source](https://github.com/gmeghnag/omc)

``` bash
Usage:
  omc [flags]
  omc [command]

Available Commands:
  certs          Inspect cluster certificates.
  collect-crd    Collect CRDs from your running cluster to ~/.omc/customresourcedefinitions/* .
  completion     Generate the autocompletion script for the specified shell
  config
  describe       Show details of a specific resource or group of resources
  etcd           Shows etcd health and status.
  get            Get kubernetes/openshift object in tabular format or wide|yaml|json|jsonpath|custom-columns.
  haproxy        Inspect haproxy config.
  help           Help about any command
  logs           Print the logs for a container in a pod
  machine-config
  mg             List or delete previously used must-gathers.
  node-logs      Display and filter node logs.
  ovn
  project        Switch to another project
  projects       List all available projects
  prometheus
  upgrade        Upgrade omc.
  use            Select the must-gather to use
  version        Print omc version

Flags:
  -h, --help               help for omc
  -n, --namespace string   If present, list the requested object(s) for a specific namespace.
  -v, --v Level            number for the log level verbosity

Use "omc [command] --help" for more information about a command.
```
