<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Target](#target)
  - [Prerequisites](#prerequisites)
- [Client Blockpass APIs](#client-blockpass-apis)
  - [1. Create SSO SessionCode](#1-create-sso-sessioncode)
  - [2. Query status of SessionCode](#2-query-status-of-sessioncode)
- [MobileApp Data Exchange](#mobileapp-data-exchange)
  - [QRCode format](#qrcode-format)
  - [SessionCodeStatus](#sessioncodestatus)
  - [App-link Format](#app-link-format)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Target

This document gives a brief introduction on how to integrate your front-end (Web or Mobile App) with Blockpass system.

## Prerequisites
Service front-end will need following information to connect with Blockpass APIs:
- `$CLIENT_ID`: ID for Service
- `$BASE_URL`: base url to request Blockapss APIs

At the moment these information will be provided directly from Blockpass team. Later Services can use Blockpass Developer page to generate these infos respectively.

Service side will need to give Blockpass team the list of required KYC fields that they want User to provide (eg name, dob, selfie, Onfido certificate etc...)

Service side will need to implement Server Sepcification along with this document 


# Client Blockpass APIs

## 1. Create SSO SessionCode

**Purpose**: 
* Client creates new SSO session. Depend on target platform one of following case may apply:
    * Web platform: Website generates a [QR code](#QRCode-format) so User can scan with Blockpass mobile app
    * Mobile platform: generate an [App-link](#App-link-Format) parameter for Blockpass mobile app, so that Service mobile application can be invoked when registration/login process is done


**Endpoint**: `/api/v0.3/service/register/${clientId}`

**Method**: POST

**Header**:
* Content-Type: application/json

**Response**: 
* **BlockpassToken** (JSON):
``` javascript
{
  "status": "success",
  "session": "b052cb34-faed-47b4-b1bb-ac38c718eace"
}
```

## 2. Query status of SessionCode

**Purpose**: 
* Monitor a session status with `SessionCode`

**Endpoint**: `/api/v0.3/service/register/${session}`

**Method**: GET

**Header**:
* Content-Type: application/json

**Response**: 
* [SessionCodeStatus](#SessionCodeStatus) (JSON):

Example
``` javascript
{
  "status": "success", // created|processing|success|failed
  "extraData": {
      "sessionData": "b052cb34-faed-47b4-b1bb-ac38c718eace",
      "extraData": {
          // service custom data
      }
  }
}
```

# MobileApp Data Exchange

## QRCode format 

Website displays QRCode containing data in JSON format below in order for the Mobile application to perform SSO

``` javascript
{
  "clientId": "...",
  "session": "b052cb34-faed-47b4-b1bb-ac38c718eace"
}
```

## SessionCodeStatus

Session Code Status returned by Blockpass Apis. 

Note:
* When SessionCode change to state `processing`. QRCode will not be accepted by MobileApp anymore. **Client must request new session in case previous login attempt fails**

Example
``` javascript
{
  "status": "created", 
  "extraData": ""
}
```

Status:

| status      | Description 
| --------    | --------
| created     | SSO session created
| processing  | SSO consumed by Mobile app. Data exchange between Mobile app and Service endpoints is in progress
| success     | SSO session processing complete
| failed      | SSO session processing failed




## App-link Format 
To be update in V2