# Blockpass AuthBackend Services

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Expected Outcome](#expected-outcome)
- [Blockpass Mobile App <-> Our Server](#blockpass-mobile-app---our-server)
  - [1. POST `/status`](#1-post-status)
    - [Our server should do following steps](#our-server-should-do-following-steps)
  - [2. POST `/login`](#2-post-login)
    - [Our Server Should Do following steps](#our-server-should-do-following-steps)
  - [3. POST `/upload`](#3-post-upload)
    - [Our server should do following steps](#our-server-should-do-following-steps-1)
- [Blockpass Data Exchange](#blockpass-data-exchange)
  - [BasicAuth](#basicauth)
  - [SSO-Complete](#sso-complete)
- [Example Implementation](#example-implementation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

This document target to build a service handle basic user case below following [Blockpass Server SpecV1](/docs/sdk/SpecV1/Server_Spec_V1.md)

## Expected Outcome

1. Using Blockpass Mobile App (V1.1+) scan Blockpass QRCode on our website

2. Mobile App call to our backend server and perform SSO login for user:

   - Old User: Generate our `service_access_token` and return to website

   - New user: Upload user data (email and selfe) from Mobile App -> our backend perform registration -> Generate our service `access_token` and return to website

## Blockpass Mobile App <-> Our Server

According to [Login sequence chart](/docs/sdk/SpecV1/Server_Spec_V1#4-mobile-app---service-sso-sequence-diagram.md). Blockpass Mobile App will call following endpoints in sequence:

### 1. POST `/status`

Mobile app begin by query current status of user. It will give our backend `code` and `sessionCode` as paramaters:

- `code`: Auth Code. Which our server using this to [bp-api-handshake](/docs/sdk/SpecV1/Server_Spec_V1#1-handshake.md) and [bp-api-queryBlockpassId](/docs/sdk/SpecV1/Server_Spec_V1#3-query-blockpassprofile.md) (Make sure that this request come from Blockpass mobile app)

- `sessionCode`: Website session code. Which we can using [bp-api-sso-complete](/docs/sdk/SpecV1/Server_Spec_V1#4-single-sign-on-complete.md) to send our `service_access_token` back to website

Request Payload Example:

``` javascript
{'sessionCode': '...', 'code': '.......'}
```

---

#### Our server should do following steps

1. Perform [BasicAuth](#BasicAuth) using `code` and `sessionCode` -> `blockpassId`.

2. Base on `blockpassId` gathering data and construct [KycRecordStatus](/docs/sdk/SpecV1/Server_Spec_V1#1-kycrecordstatus.md) as response.

- **Old User**: Since this user already complete our registration process => We create our `service_access_token` and send back to Website via [bp-api-sso-complete](/docs/sdk/SpecV1/Server_Spec_V1#4-single-sign-on-complete.md)

``` javascript
{ 
  identities: [ 
     { slug: 'email', status: 'approved' },
     { slug: 'selfie', status: 'approved' }
   ],
  certificates:[],
  createdDate: 'ISO-Date-Format'
  status: 'approved'
}
```

- **New User**: This is not found user. We expect user provide`email` and `selfie` in order to sign-up

``` javascript
{
  identities: [
     { slug: 'email', status: '' },
     { slug: 'selfie', status: '' }
   ],
  certificates:[],
  status: 'notFound'
}
```

### 2. POST `/login`

In case user `notFound` returned by `/status` api. Blockpass Mobile App will call `/login` to begin upload user data procedure.

Request Payload Example:

``` javascript
{'sessionCode': '...', 'code': '.......'}
```

---

#### Our Server Should Do following steps

1. Perform [BasicAuth](#BasicAuth) using `code` and `sessionCode` -> `blockpassId`.

2. Create new **DataRecord** associated with `blockpassId` and **Upload Session**, which identities by `one_time_pass` -> (`blockpass_token`, `sessionCode`, `record_id`)

Our Server Response:

``` javascript
{
    nextAction: 'upload', // action code for mobile app
    accessToken: '...',   // one-time password for update data

    // expected fileds and certificates
    requiredFields: ['phone', 'email'],
    certs: ['onfido']
}
```

### 3. POST `/upload`

Mobile app will collect Raw user data, certificate ( asking user permission ) and send request `/uploadData`. Of couse `one_time_pass` in step 1 attached for Authentication

This request body will be format with `multipart/form-data`

Request Payload Example:

``` text
POST  HTTP/1.1
Host: auth-blockpass.org
Cache-Control: no-cache
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="accessToken"

xxxxxxxxxxxxxyyyyyyyy
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="email"

abc@def.com
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="selfie"; filename="image.svg"
Content-Type: image/svg+xml


------WebKitFormBoundary7MA4YWxkTrZu0gW--
```

---

#### Our server should do following steps

1. Check `one_time_pass` under `accessToken` params for authentication and restore **Upload Session** context

2. Fill user raw data to **DataRecord** and complete user registration flow (We can perform matching user base on their provided data) and create **User**

3. We create our `service_access_token` and send back to Website via [bp-api-sso-complete](/docs/sdk/SpecV1/Server_Spec_V1#4-single-sign-on-complete.md)

## Blockpass Data Exchange

### BasicAuth

This is procedure to make sure that in-comming request come from Blockpass Mobile App.

Input

- `code`: Auth code Blockpass from Mobile App
- `session_code`: Session code from Mobile App

Output

- `blockpassId`: Blockpass Id of user
- `blockpass_token`: Access token associated with Blockpass Id

---

1. Send POST to https://sandbox-api.blockpass.org/api/v0.3/oauth2/token/

Using `code` to obtain Blockpass token for services. Which can be use to query user profile in next step

- Body(application/json):

``` javascript
{
    "client_id": "developer_service",
    "client_secret": "developer_service",
    "code": "...",
    "session_code": "...",
    "grant_type": "authorizationcode"
}
```

- Response Code:
  - 200: Success
  - 400: Invalid code => Terminate request return error to client

- Example Success Response

``` javascript
{
    "access_token" : "....",
    "expires_in" : 36000, // miliseconds
    "refresh_token" : "...."
}
```

2. Send POST to https://sandbox-api.blockpass.org/api/v0.3/oauth2/profile

- Header:

``` javascript
{
    "Authorization": "{blockpass_token}"
}
```

- Example Success Response

``` javascript
{
    "id" : "....",          // blockpassId
    // Please ignore others fields. in-development status
}
```

### SSO-Complete

This is procedure to send `service_access_token` to website and complete sso session

Input

- service_access_token
- blockpass_token
- session_Code

Output

- None

---

1. Send POST to https://sandbox-api.blockpass.org/api/v0.3/service/complete/

- Header:

``` javascript
{
    "Authorization": "{blockpass_token}"
}
```

- Body(application/json):

``` javascript
{
    "result": "success",
    "custom_data": {
        "session_Code": session_code,
        "extraData": {
            'your_service_accessControl': your_service_accessControl
            // anything else
        }
    }
}
```

- Example Success Response

``` javascript
{
    "status": "success"
}
```

## Example Implementation

- Python: [https://github.com/blockpass-org/service-auth-example-python](https://github.com/blockpass-org/service-auth-example-python)

- Node: <repo_link>
