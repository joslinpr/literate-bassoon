<!-- TOC start (generated with https://github.com/derlin/bitdowntoc) -->

- [How can I create a service account for scripted access?](#how-can-i-create-a-service-account-for-scripted-access)
   * [Create SA](#create-sa)
   * [View SA](#view-sa)
   * [View Access Tokens](#view-access-tokens)
   * [Delete (Revoke) Access Tokens](#delete-revoke-access-tokens)
   * [Delete (Revoke) Service Account](#delete-revoke-service-account)

<!-- TOC end -->


# How can I create a service account for scripted access?

To create a service account, with a session token which does not expire,
   for use with scripted access, use the `oc create sa` command, and
   pass the name to give the service account.

## Create SA

``` bash
$ oc create sa robot
serviceaccount "robot" created
```

## View SA

To view details of the service account created, run `oc describe` on the
service account resource.

``` bash
$ oc describe sa robot
Name:        robot
Namespace:   cookbook
Labels:      <none>
Annotations: <none>

Image pull secrets: robot-dockercfg-vl9qn

Mountable secrets:  robot-token-mhf9x
robot-dockercfg-vl9qn

Tokens:             robot-token-4nkdw
robot-token-mhf9x
```

Secrets for two access tokens will be created.

One is mounted into any containers which are run as this service account
to allow an application running in the container to access the REST API
if required.

The second is referenced in the separate secret for the docker
configuration used when pulling images from the internal docker
registry.

Of the two tokens, the first token, which would normally be used from
within containers running with this service account to access the REST
API, also be used when accessing the REST API from outside of the
cluster.

To view the access token, run `oc describe` on the secret.

## View Access Tokens

``` bash
$ oc describe secret robot-token-mhf9x
Name:        robot-token-mhf9x
Namespace:   cookbook
Labels:      <none>
Annotations: kubernetes.io/service-account.name=robot

Type:        kubernetes.io/service-account-token

Data
====
ca.crt:         1070 bytes
namespace:      8 bytes
service-ca.crt: 2186 bytes
token:          eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...
```

The token will not expire. If you need to revoke the access token you
can delete the secret for the access token using `oc delete` and a new
secret will be created.

## Delete (Revoke) Access Tokens

``` bash
$ oc delete secret robot-token-mhf9x
secret "robot-token-mhf9x" deleted
```

The service account, along with any secrets associated with it, can be
deleted by running `oc delete` against the service account.

## Delete (Revoke) Service Account

``` bash
$ oc delete sa robot
serviceaccount "robot" deleted
```

Note that the service account will by default have no access to do
anything within the project via the REST API. You will need to grant
appropriate roles to the service account to enable it to view or make
changes to any resource objects.

For further information on creating and using service accounts see:

- [https://docs.openshift.org/latest/dev_guide/service_accounts.html](https://docs.openshift.org/latest/dev_guide/service_accounts.html){target="_blank"}

<!-- vim: set ai et nu cin sts=3 sw=3 ts=3 tw=100 filetype=markdown :-->
