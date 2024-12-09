
# The Book of Knowledge

## SCC.md

## OpenShift Container Platform Security Context Constraint (SCC)

### Working With SCCs

Use the `oc adm policy` commands to work with SCC assignments

``` text

    Available Commands:
      add-scc-to-group                 Add a security context constraint to groups
      add-scc-to-user                  Add a security context constraint to users or a service account
      remove-scc-from-group            Remove a group from a security context constraint
      remove-scc-from-user             Remove a user from a security context constraint

```

Use the `oc adm policy` commands to check SCC assignments

``` text

    Available Commands:
      scc-review                       Check which service account can create a pod
      scc-subject-review               Check whether a user or a service account can create a pod
      who-can                          List who can perform the specified action on a resource

```

You may need to check who has access to SCCs.  Since they are not scoped
by-namespace, add -A or --all-namespaces

``` bash

$ oc auth can-i get scc -A
 yes
$ oc auth can-i edit scc -A
yes

# As another user

$ oc auth can-i edit scc -A --as=default
no

```

### Check Required SCC

SCC has assigned priority.  Custom SCCs may override **restricted** or
**restricted-v2**.  If that happens, check priority, and optionally set to null.
null is the lowest priority.

``` bash

# Check Priority:

$ oc -n openshift-monitoring get pod cluster-monitoring-operator-xxxxx -o json | jq '.metadata.annotations["openshift.io/scc"]'
  "nonroot"

# Patching Priority to null:

$ oc patch scc its-jenkins-prod --type merge --patch '{"priority":null}' --dry-run=server
$ oc patch scc its-jenkins-prod --type merge --patch '{"priority":null}' --dry-run=none

# Check Required Priority

$ oc get pod newops-noc-integration-deployments-12 -o yaml | oc adm policy scc-subject-review -f -
RESOURCE                                    ALLOWED BY
Pod/newops-noc-integration-deployments-12   restricted-v2

```

### References

- [Documentation](https://docs.openshift.com/container-platform/4.14/authentication/managing-security-context-constraints.html)

- [Pod with custom image not running in RHOCP 4](https://access.redhat.com/solutions/6987550?band=se&seSessionId=7255840e-8a16-440e-a0c6-33dc499bd9f8&seSource=Recommendation&seResourceOriginID=1a21ca4e-919a-460b-8dca-12c3de3a37b5)

- [PODs in the openshift-cluster-storage-operator namespace cannot deploy new
version of pod with CreateContainerConfigError in Openshift 4](https://access.redhat.com/solutions/7007779?band=se&seSessionId=7255840e-8a16-440e-a0c6-33dc499bd9f8&seSource=Recommendation&seResourceOriginID=bed0758f-834a-4bc8-9089-a1609ceb3e30)

[//]: # ( vim: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
