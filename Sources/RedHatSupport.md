
# The Book of Knowledge

<!-- TOC start -->
- [Using the Red Hat Support Tool (RHST) REST API](#using-the-red-hat-support-tool-rhst-rest-api)
- [Pre-Requisites](#pre-requisites)
- [The Commands](#the-commands)
  * [1. listproducts - command to list products](#1-listproducts---command-to-list-products)
    + [Example: listproducts](#example-listproducts)
  * [2. listversions - command to list versions of a product](#2-listversions---command-to-list-versions-of-a-product)
    + [Example: listversions](#example-listversions)
  * [3. listattachments - command to list attachments for the specified support](#3-listattachments---command-to-list-attachments-for-the-specified-support)
    + [Example: listattachments](#example-listattachments)
  * [4. listentitlements - command to list your current entitlements](#4-listentitlements---command-to-list-your-current-entitlements)
    + [Example: listentitlements](#example-listentitlements)
  * [5. listcasegroups - command to list case groups](#5-listcasegroups---command-to-list-case-groups)
    + [Example: listcasegroups](#example-listcasegroups)
  * [6. listcases - command to list your open support cases.](#6-listcases---command-to-list-your-open-support-cases)
    + [Note 1. Filter the Response](#note-1-filter-the-response)
    + [Example: Note 1](#example-note-1)
    + [Note 2. Filter by casegroup](#note-2-filter-by-casegroup)
    + [Example: Note 2](#example-note-2)
    + [Example 1. Default RHST behaviour](#example-1-default-rhst-behaviour)
    + [Example 2. For filtering by case groupNumber](#example-2-for-filtering-by-case-groupnumber)
    + [Example 3. For filtering by multiple case groupNumbers](#example-3-for-filtering-by-multiple-case-groupnumbers)
  * [7.  getcase - command to find a specific case by number.](#7--getcase---command-to-find-a-specific-case-by-number)
    + [Example: getcase](#example-getcase)
  * [8.  addattachment - command to add an attachment to a case.](#8--addattachment---command-to-add-an-attachment-to-a-case)
    + [Example: addattachment](#example-addattachment)
  * [9.  getattachment - command to find a specific attachment by uuid.](#9--getattachment---command-to-find-a-specific-attachment-by-uuid)
    + [Example: getattachment](#example-getattachment)
  * [10. modifycase](#10-modifycase)
    + [Modify severity](#modify-severity)
    + [Modify the Case type](#modify-the-case-type)
    + [Modify Status](#modify-status)
    + [Modify alternate id.](#modify-alternate-id)
    + [Modify product](#modify-product)
    + [Modify version](#modify-version)
  * [11. opencase - command to open a new support case.](#11-opencase---command-to-open-a-new-support-case)
      - [To see the recommendations before opening the case.](#to-see-the-recommendations-before-opening-the-case)
    + [Example: opencase](#example-opencase)
      - [To open a support case.](#to-open-a-support-case)
    + [Example 1. Opening A Case](#example-1-opening-a-case)
    + [Example 2. Opening A Case with a Casegroup (Example: 74975)](#example-2-opening-a-case-with-a-casegroup-example-74975)
  * [12. addcomment - command to add a comment to a case.](#12-addcomment---command-to-add-a-comment-to-a-case)
    + [Example: addcomment](#example-addcomment)
  * [13. kb - command to find a knowledge base solution by ID](#13-kb---command-to-find-a-knowledge-base-solution-by-id)
    + [Check for solutions](#check-for-solutions)
    + [Example: Check for solutions](#example-check-for-solutions)
    + [Check for articles](#check-for-articles)
    + [Example - Check for articles](#example---check-for-articles)
  * [14. search - command to search the entire knowledge base for solutions](#14-search---command-to-search-the-entire-knowledge-base-for-solutions)
    + [Example: search](#example-search)
  * [15. diagnose - command to send text to Red Hat for analysis.](#15-diagnose---command-to-send-text-to-red-hat-for-analysis)
    + [Example: diagnose](#example-diagnose)
    + [Using Proxy configuration in the curls](#using-proxy-configuration-in-the-curls)
- [General Note](#general-note)
<!-- TOC end -->

## RedHatSupport.md

## Using the Red Hat Support Tool (RHST) REST API

The Red Hat Support Tool (RHST) is a command line utility shipped in RHEL
6, 7 and 8, which allows users to interact with our Case Management APIs.
One of its primary use-cases is the ability to programmatically upload
attachments to support cases and Secure FTP.
Owing to it's low usage, Red Hat Support Tool has been deprecated in RHEL
8 and will not be shipped in RHEL 9 onwards. However, this doesn't affect
the support and maintenance of the tool in RHEL 6/7/8, and we shall
continue to maintain and push relevant updates / bug-fixes to the tool
till the maintenance support phase.
The article contains the curl command equivalent of the API based RHST
commands.

# Pre-Requisites

* Install **jq**, which is used to filter the curl response.

# The Commands

## 1. listproducts - command to list products

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v2/products' | jq ".[].name"

```

### Example: listproducts

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v2/products' | jq ".[].name"

```

## 2. listversions - command to list versions of a product

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v2/products/<urlencoded_product_name>/versions' | jq ".[].name"

```

### Example: listversions

```

Product: Red Hat Enterprise Linux
curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v2/products/Red%20Hat%20Enterprise%20Linux/versions' | jq ".[].name"

```

## 3. listattachments - command to list attachments for the specified support

case

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/<case_number>/attachments' | jq '. | [.| map(.) | .[] | {fileName: .fileName, uuid: .uuid, description: .description, size_in_bytes: .size}]'

```

### Example: listattachments

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/02290113/attachments' | jq '. | [.| map(.) | .[] | {fileName: .fileName, uuid: .uuid, description: .description, size_in_bytes: .size}]'

```

## 4. listentitlements - command to list your current entitlements

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/entitlements?showAll=False'  | jq '. | [.| map(.) | .[] | {Name: .name, ServiceLevel: .serviceLevel, SLA: .slaProcessId, SupportLevel: .supportLevel, StartDate: .startDate, EndDate: .endDate}]'

```

### Example: listentitlements

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/entitlements?showAll=False'  | jq '. | [.| map(.) | .[] | {Name: .name, ServiceLevel: .serviceLevel, SLA: .slaProcessId, SupportLevel: .supportLevel, StartDate: .startDate, EndDate: .endDate}]'

```

## 5. listcasegroups - command to list case groups

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/accounts/casegroups' | jq ".[].name"

```

### Example: listcasegroups

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/accounts/casegroups' | jq ".[].name"
To get details of a particular case group
curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/accounts/casegroups/<case_group>'
curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/accounts/casegroups/74975'

```

## 6. listcases - command to list your open support cases.

The listcases command comes with various sub-options, which are available as the POST data to be sent in the request. They are as below -
    * sortField - Sort cases by a particular field. Available fields to sort by are: caseNumber, createdDate, lastModifiedDate, severity, status.
    * sortOrder - For sorting the result in a particular order. Available values - ASC, DESC.
    * onlyUngrouped- true, for Including ungrouped cases in results else false.
    * includeClosed - Show closed cases. Available values - true, false.
    * groupNumber - Show the cases for a particular case group in your account.
    * maxResults and offset are used to limit the results.

### Note 1. Filter the Response

    To filter the response, append the below given "jq" as in the curl as shown below.

```

| jq '.cases | [.| map(.) | .[] | {Case_Number: .caseNumber, Summary: .summary, Severity: .severity, Status: .status, GroupName: .groupName, GroupNumber: .groupNumber}]'

```

### Example: Note 1

```

curl -u <customer_portal_id> -X POST https://api.access.redhat.com/support/v1/cases/filter -H 'accept: application/json' -H 'content-type: application/json'  -d '{"maxResults": 50, "offset": 0, "sortField": "<sortField>", "sortOrder": "<sortOrder>", "onlyUngrouped": <onlyUngrouped>, "includeClosed":<includeClosed>}' | jq '.cases | [.| map(.) | .[] | {Case_Number: .caseNumber, Summary: .summary, Severity: .severity, Status: .status, GroupName: .groupName, GroupNumber: .groupNumber}]'

```

### Note 2. Filter by casegroup

Cases can also be filtered by casegroups by passing the groupNumber in the filter request. Refer example 2, 3 below Use following curl to get the list of the case groups(their groupNumbes) in your account -

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/accounts/casegroups'

```

### Example: Note 2

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/accounts/casegroups'

```

### Example 1. Default RHST behaviour

```

curl -u jane.doe -X POST https://api.access.redhat.com/support/v1/cases/filter -H 'accept: application/json' -H 'content-type: application/json'  -d '{"maxResults": 50, "offset": 0, "sortField": "caseNumber", "sortOrder": "DESC", "onlyUngrouped": false, "includeClosed":false}'

```

### Example 2. For filtering by case groupNumber

```

curl -u jane.doe -X POST https://api.access.redhat.com/support/v1/cases/filter -H 'accept: application/json'  -H 'content-type: application/json'  -d '{"maxResults": 50, "offset": 0, "sortField": "severity", "sortOrder": "DESC", "onlyUngrouped": false, "includeClosed":false, "groupNumber": "74975"}'

```

### Example 3. For filtering by multiple case groupNumbers

```

curl -u jane.doe -X POST https://api.access.redhat.com/support/v1/cases/filter -H 'accept: application/json' -H 'content-type: application/json' -d '{"includeClosed": false, "maxResults": 50, "offset": 0, "sortField": "caseNumber", "sortOrder": "DESC", "groupNumbers": ["74973", "74975"], "onlyUngrouped": false}'

```

## 7.  getcase - command to find a specific case by number.

    * To get all case details.

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/<case_number>' | jq '{Case_Number: .caseNumber, Case_Type: .caseType, Severity: .severity , Status: .status, Alternate_Id: .alternateId, Product: .product, Version: .version , Support_level: .entitlementSla, Owner: .contactName, Red_Hat_owner: .ownerId, Group: .groupNumber,Opened: .createdDate, Opened_by: .createdById, Last_updated_at: .lastModifiedDate, Last_updated_by: .lastModifiedById, Summary: .summary, Description: .description}'

```

### Example: getcase

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/02290113' | jq '{Case_Number: .caseNumber, Case_Type: .caseType, Severity: .severity , Status: .status, Alternate_Id: .alternateId, Product: .product, Version: .version , Support_level: .entitlementSla, Owner: .contactName, Red_Hat_owner: .ownerId, Group: .groupNumber,Opened: .createdDate, Opened_by: .createdById, Last_updated_at: .lastModifiedDate, Last_updated_by: .lastModifiedById, Summary: .summary, Description: .description}'

```

* To get case recommendations

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/<case_number>' | jq '.caseResourceLinks | [.| map(.) | .[] | {title: .title, link: .resourceViewURI}]'

### Example

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/02290113' | jq '.caseResourceLinks | [.| map(.) | .[] | {title: .title, link: .resourceViewURI}]'

```

* Get case discussions (case comments)

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/<case_number>' | jq '.comments | [.| map(.) | .[] | {comment: .commentBody, Author: .lastModifiedById, Date: .lastModifiedDate}]'
curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/02290113' | jq '.comments | [.| map(.) | .[] | {comment: .commentBody, Author: .lastModifiedById, Date: .lastModifiedDate}]'

```

## 8.  addattachment - command to add an attachment to a case.

    * Refer to the Red Hat Secure FTP - User Guide . There is no upload size limit for SFTP.
    * For https uploads, refer to the following. Please note this has a size limit of 1GB.

```

curl -u <customer_portal_id> -F "file=@<path_to_file>" -F "description=<description>" -X POST https://api.access.redhat.com/support/v1/cases/<case_number>/attachments/ -D -

```

### Example: addattachment

```

curl -u jane.doe -F "file=@/tmp/my_sosreport" -F "description=Sosreport for case" -X POST https://api.access.redhat.com/support/v1/cases/02290113/attachments/ -D -

```

## 9.  getattachment - command to find a specific attachment by uuid.

For downloading an attachment, there are two steps involved :-
* Fetch the download link

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/<case_number>/attachments' | jq '.[]| select(.uuid=="<attachment_uuid>")' | jq .link

```

Please note if there is any issue with the jq, then call the
listattachments command curl and check the “link” field for your
attachment uuid.
* Download the attachment from that link. The file can be downloaded from any options as below -
* Saves the file by uuid.

```

curl --fail -L -O -u <customer_portal_id> -X GET <link_obtained_from_above_curl>

```

* Saves file by given filename and location in the -o

```

curl --fail -L -u <customer_portal_id> -X GET <link_obtained_from_above_curl> -o <your_filename>

```

* Saves the file by the same name as uploaded on the case.

```

wget --content-disposition --user <customer_portal_id> --ask-password  <link_obtained_from_above_curl>

```

### Example: getattachment

* Fetch the download link as below

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/02290113/attachments' | jq '.[]| select(.uuid=="6ec52168-f043-47d7-853a-65cf38d5bdc1")' | jq .link

```

* Download the attachment with the link obtained from above curl using
either of the below given curl/wget.

```

curl --fail -L -O -u jane.doe -X GET https://attachments.access.redhat.com/hydra/rest/cases/02290113/attachments/6ec52168-f043-47d7-853a-65cf38d5bdc1
curl --fail -L -u jane.doe -X GET https://attachments.access.redhat.com/hydra/rest/cases/02290113/attachments/6ec52168-f043-47d7-853a-65cf38d5bdc1 -o /tmp/downloaded_file
wget --content-disposition --user jane.doe --ask-password  https://attachments.access.redhat.com/hydra/rest/cases/02290113/attachments/6ec52168-f043-47d7-853a-65cf38d5bdc1

```

## 10. modifycase

For modifying a case, we have the following options in RHST.

### Modify severity

a. Find the severities

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/metadata/severities' | jq .items

### Example

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/metadata/severities' | jq .items

```

b. Now, modify the case

```

curl -u <customer_portal_id>  -X PUT https://api.access.redhat.com/support/v1/cases/<case_number> -d '{"severity": "<Severity_obtained_from_above_curl>"}'

### Example

curl -u jane.doe -X PUT https://api.access.redhat.com/support/v1/cases/02290113 -d '{"severity": "3 (Normal)"}'

```

### Modify the Case type

a. Find the case types

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/metadata/types' | jq .items

### Example

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/metadata/types' | jq .items

```

b. Modify the case type

```

curl -u <customer_portal_id> -X PUT https://api.access.redhat.com/support/v1/cases/<case_number> -d '{"caseType": "<Casetype_obtained_from_above_curl>"}'

### Example

curl -u jane.doe -X PUT https://api.access.redhat.com/support/v1/cases/02290113 -d '{"caseType": "Defect / Bug"}'

```

### Modify Status

a. Find the different statuses

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/cases/metadata/statuses' | jq .items

### Example

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/cases/metadata/statuses' | jq .items

```

b. Now, modify the case status

```

curl -u <customer_portal_id> -X PUT https://api.access.redhat.com/support/v1/cases/<case_number> -d '{"status": "<Status_obtained_from_above_curl>"}

### Example

curl -u jane.doe -X PUT https://api.access.redhat.com/support/v1/cases/02290113 -d '{"status": "Waiting on Red Hat"}'

```

### Modify alternate id.

```

curl -u <customer_portal_id> -X PUT https://api.access.redhat.com/support/v1/cases/<case_number> -d '{"alternateId": "<alternate_id>"}'

### Example

curl -u jane.doe -X PUT https://api.access.redhat.com/support/v1/cases/02290113 -d '{"alternateId": "1234"}'

```

### Modify product

Products can be found from listproducts command curl.

```

curl -u <customer_portal_id> -X PUT https://api.access.redhat.com/support/v1/cases/<case_number> -d '{"product": "<product>", "version":"<version>"}'

### Example

curl -u jane.doe -X PUT https://api.access.redhat.com/support/v1/cases/02290113 -d '{"product": "Red Hat Enterprise Linux", "version":"8.0"}'

```

### Modify version

Versions for a specific product can be found from the listversions command curl.

```

curl -u <customer_portal_id> -X PUT https://api.access.redhat.com/support/v1/cases/<case_number> -d '{"product":"<product>","version":"<version>"}'

### Example

curl -u jane.doe -X PUT https://api.access.redhat.com/support/v1/cases/02290113 -d '{"product":"Red Hat Enterprise Linux","version":"8.0"}'

```

## 11. opencase - command to open a new support case.

#### To see the recommendations before opening the case.

```

curl -u <customer_portal_id> -X POST 'https://api.access.redhat.com/support/search/recommendations' --header 'Accept: application/json' --header 'Content-Type: application/json' -d '{ "product":"<product>", "version":"<version>", "summary":"<summary_for_case>"}' | jq '.response.docs | [.| map(.) | .[] | {url: .view_uri, Title: .allTitle}]'

```

### Example: opencase

```

curl -u jane.doe -X POST 'https://api.access.redhat.com/support/search/recommendations' --header 'Accept: application/json' --header 'Content-Type: application/json' -d '{ "product":"Red Hat Enterprise Linux", "version":"8.1", "summary":"Test summary"}' | jq '.response.docs | [.| map(.) | .[] | {url: .view_uri, Title: .allTitle}]'

```

#### To open a support case.

```

curl -u <customer_portal_id> -X POST https://api.access.redhat.com/support/v1/cases -H 'accept: application/json' -H 'content-type: application/json' -d '{"summary": "<summary", "description": "<description>", "product": "<product>","version": "<version>","caseType": "<caseType","severity": "<severity>"}'

```

### Example 1. Opening A Case

```

curl -u jane.doe -X POST https://api.access.redhat.com/support/v1/cases -H 'accept: application/json' -H 'content-type: application/json' -d '{"summary": "Test Summary", "description": "This is test description for new case created", "product": "Red Hat Enterprise Linux","version": "7.9","caseType": "Defect / Bug","severity": "3 (Normal)"}'

```

### Example 2. Opening A Case with a Casegroup (Example: 74975)

```

curl -u jane.doe -X POST https://api.access.redhat.com/support/v1/cases -H 'accept: application/json' -H 'content-type: application/json' -d '{"summary": "Test Summary", "description": "This is test description for new case created", "product": "Red Hat Enterprise Linux","version": "7.9","caseType": "Defect / Bug","severity": "3 (Normal)", "groupNumber": "74975"}'

```

## 12. addcomment - command to add a comment to a case.

```

curl -u <customer_portal_id> -X POST https://api.access.redhat.com/support/v1/cases/<case_number>/comments -H 'accept: application/json' -H 'content-type: application/json'  -d '{"caseNumber": "<case_number>", "commentBody": "<Comment_text>"}'

```

### Example: addcomment

```

curl -u jane.doe -X POST https://api.access.redhat.com/support/v1/cases/02290113/comments -H 'accept: application/json' -H 'content-type: application/json'  -d '{"caseNumber": "02290113", "commentBody": "This is my comment text"}'

```

## 13. kb - command to find a knowledge base solution by ID

Please first check the /solutions endpoint. If the response from this is
404, then check the /articles endpoint. Hence, both curls are given below.

### Check for solutions

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/solutions/<solution_id>' | jq -r '{Title: .title, Issue: .issue.text, Environment: .environment.text, Resolution: .resolution.text, Last_Modified_on: .lastModifiedDate}'

```

### Example: Check for solutions

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/solutions/61546' | jq -r '{Title: .title, Issue: .issue.text, Environment: .environment.text, Resolution: .resolution.text, Last_Modified_on: .lastModifiedDate}'

```

### Check for articles

```

curl -u <customer_portal_id> -X GET 'https://api.access.redhat.com/support/v1/articles/<article_id>' | jq '{Title: .title, URL: .viewURI, Created_at: .createdDate, Last_Modified_Date: .lastModifiedDate, Body: .body.text}'

```

### Example - Check for articles

```

curl -u jane.doe -X GET 'https://api.access.redhat.com/support/v1/articles/3724231' | jq '{Title: .title, URL: .viewURI, Created_at: .createdDate, Last_Modified_Date: .lastModifiedDate, Body: .body.text}'

```

## 14. search - command to search the entire knowledge base for solutions

```

curl -u <customer_portal_id> -X POST --header 'Content-Type: application/json' --header 'Accept: application/json'  -d '{ "start":0, "rows":50, "q":"<text_to_be_searched>", "expression":"fq=documentKind%3A%22Solution%22"}' 'https://api.access.redhat.com/support/search/v2/kcs' | jq '.response.docs | [.| map(.) | .[] | {url: .view_uri, Title: .allTitle, Abstract: .abstract}]'

```

### Example: search

Search term - “*libvirt error code: 1, message: internal error HTTP response code 404*"

```

curl -u jane.doe -X POST --header 'Content-Type: application/json' --header 'Accept: application/json'  -d '{ "start":0, "rows":50, "q":"libvirt error code: 1, message: internal error HTTP response code 404", "expression":"fq=documentKind%3A%22Solution%22"}' 'https://api.access.redhat.com/support/search/v2/kcs' | jq '.response.docs | [.| map(.) | .[] | {url: .view_uri, Title: .allTitle, Abstract: .abstract}]'

```

## 15. diagnose - command to send text to Red Hat for analysis.

```

curl -u <customer_portal_id> -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{ "summary": "<plain_text_for_analysis>"}' https://api.access.redhat.com/support/search/recommendations | jq '.response.docs | [.| map(.) | .[] | {url: .view_uri, Title: .allTitle}]'

```

This gives top 10 recommendations.

### Example: diagnose

Text to be diagnosed - "*libvirt error code: 1, message: internal error HTTP response code 404*"

```

curl -u jane.doe -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{ "summary": "libvirt error code: 1, message: internal error HTTP response code 404"}' https://api.access.redhat.com/support/search/recommendations | jq '.response.docs | [.| map(.) | .[] | {url: .view_uri, Title: .allTitle}]'

```

### Using Proxy configuration in the curls

If the user has a proxy configured, then the --proxy option can be used in the curl commands. Given below is a example with the addattachment command curl with authenticated and unauthenticated proxy.
Proxy - *http://localhost:8080*

```

curl -u jane.doe --proxy http://localhost:8080 -F "file=@/home/jane/my_sosreport" -X POST https://api.access.redhat.com/support/v1/cases/02290113/attachments/ -D -

```

If a user has a authenticated proxy(http://localhost:8080), specify it’s username(rstuser) and password(rstpassword) in as below

```

curl -u jane.doe --proxy rstuser:rstpassword@localhost:8080 -F "file=@/home/jane/my_sosreport" -X POST https://api.access.redhat.com/support/v1/cases/02290113/attachments/ -D -

```

# General Note

1.   If you run into jq related errors for example as below, please run your curl without jq to check the curl response first .

```

jq: error (at <stdin>:0, ): Cannot iterate over null (null) OR q: error (at <stdin>:0): Cannot index array with string)

```

[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
[//]: # ( vim: set ai noet nu sts=4 sw=4 ts=4 tw=78 filetype=markdown :)
