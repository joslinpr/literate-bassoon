
# The Book of Knowledge

## OpenShiftAccounts.md

## Managing Accounts in OpenShift / Kubernetes

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

## Finding All Rolebindings for an Account

To find all RoleBindings containing a specific group in OpenShift 4, you can use the `oc` command-line tool with the `-o json` output format and `jq` for processing the JSON data. Here’s a step-by-step process:

1. **List all RoleBindings**:
   Use the following command to list all RoleBindings in a namespace or across the cluster:

   ```sh
   oc get rolebindings --all-namespaces -o json
   ```

2. **Filter RoleBindings containing a specific group**:
   You can pipe the output to `jq` to filter RoleBindings that contain the specified group. Replace `YOUR_GROUP_NAME` with the name of the group you are looking for.

   ```sh
   oc get rolebindings --all-namespaces -o json | jq '.items[] | select(.subjects[]?.kind == "Group" and .subjects[]?.name == "YOUR_GROUP_NAME")'
   ```

3. **Extract specific information**:
   If you want to extract specific information, such as the name and namespace of the RoleBindings, you can further refine the `jq` query:

   ```sh
   oc get rolebindings --all-namespaces -o json | jq '.items[] | select(.subjects[]?.kind == "Group" and .subjects[]?.name == "YOUR_GROUP_NAME") | {namespace: .metadata.namespace, name: .metadata.name}'
   ```

Here's an example command that finds RoleBindings containing the group `UDLDHL-OCPTeam-ecs-am-ramp-admin`:

```sh

oc get rolebindings --all-namespaces -o json | jq '.items[] | select(.subjects[]?.kind == "Group" and .subjects[]?.name == "UDLDHL-OCPTeam-ecs-am-ramp-admin") | {namespace: .metadata.namespace, name: .metadata.name}'

```

This command will output the namespace and name of each RoleBinding that includes the specified group.

**Note**: Ensure you have the necessary permissions to list RoleBindings across all namespaces. If you only need to search within a specific namespace, you can omit the `--all-namespaces` flag and specify the namespace:

```sh

oc get rolebindings -n YOUR_NAMESPACE -o json | jq '.items[] | select(.subjects[]?.kind == "Group" and .subjects[]?.name == "YOUR_GROUP_NAME") | {namespace: .metadata.namespace, name: .metadata.name}'

```

Replace `YOUR_NAMESPACE` with the namespace you want to search within.
[//]: # ( vm: set ai et nu sts=2 sw=2 ts=2 tw=78 filetype=markdown :)
