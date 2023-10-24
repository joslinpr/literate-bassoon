
##  OpenShiftAccounts.md
##  Managing Accounts in OpenShift / Kubernetes
### Create an Admin Service Account

``` bash
# Define Service Account Name and Namespace
# Do not create cluster-wide SA unless you have a really good reason
SA=svc-dgf-edm-us-dev-admin
NS=dgf-edm-us-dev
# Create the Service Account
oc -n "$NS" create sa $SA
# Add Roles, in this case "admin"
oc policy add-role-to-user admin system:serviceaccount:$NS:$SA
oc describe sa svc-dgf-edm-us-dev-admin
# Verify assigned roles - note the funky quoting around $SA
oc get clusterrolebindings -o json | jq '.items[] | select(.subjects[0].name=="'$SA'")' | jq '.roleRef.name'
# Export the login token
oc -n "$NS"  get secret svc-dgf-edm-us-dev-admin-token-qscd2  -o yaml | oc neat -f - > svc-dgf-edm-us-dev-admin-token-qscd2.yaml
```

[//]: # ( vim: set ai et nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
