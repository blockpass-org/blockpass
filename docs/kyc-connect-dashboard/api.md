# API

## Before you begin

Make sure you have received your API key

> :point_right: contact us to get your `API key`

## Extract and Archive. Best practice

Personal KYC data should not sit in KYC Connect database forever.
We recommend using the API described below to extract data and store them in a secure environment.

Once data of a profile have been extracted, you can auto-archive it in the KYC Connect dashboard. All raw KYC data will be deleted. Only meta-data will remain (status, history, certificates if any)


## KYC data attributes description:

- `refId`: Merchant reference ID
- `blockPassID`: Blockpass registration ID
- `status`: Status of KYC application (`waiting` | `inreview` | `approved`)
- `isArchived`: KYC application archived status

  - `true`: All KYC applications' attributes were deleted by operator
  - `false`: Data are still available in KYC Connect database

- `inreviewDate`: Start review date
- `waitingDate`: Last submitted date
- `approvedDate`: Approval date
- `willArchiveAtDate`: KYC Connect will auto archive when  date is reached (only returned if `Archive after extract data` was defined in `API key` management settings)

## Get all users statuses

Retrieve current status of all KYC applications

```js
curl -X GET \ https://<DASHBOARD_URL>/kyc/1.0/connect/<CLIENT_ID>/applicants/<STATUS> \
  -H 'Authorization: <API_Key>' \
  -H 'Cache-Control: no-cache'

```

Path parameters:

- STATUS (optional): Default value return all statuses. Possible values for specific filter (`waiting` | `inreview` | `approved`)

Query parameters:

- skip (optional) : Number of records skipped
- limit (optional) : Maximum of records returned

returns the list of applicants and their current KYC statuses

```json
{
  "status": "success",
  "data": {
    "records": [
      {
        "status": "waiting",
        "isArchived": false,
        "_id": "5bbad529853cb200150fb78d",
        "blockPassID": "5bbad527e37b52831146dse1",
        "refId": "random-1538970917175"
      },
      {...}
    ],
    "total": 2,
    "skip": 0,
    "limit": 5
  }
}
```

## Get status by RefID

```js
curl -X GET \
  https://<DASHBOARD_URL>/kyc/1.0/connect/<CLIENT_ID>/refId/<REFID> \
  -H 'Authorization: <API_Key' \
  -H 'cache-control: no-cache'
```

returns current status and history of status changes

```json
{
  "status": "success",
  "data": {
    "status": "inreview",
    "isArchived": false,
    "refId": "1849-4849-3848-1944",
    "blockPassID": "5fe95a995f8c44000e972445",
    "inreviewDate": "2018-11-12T10:49:17.973Z",
    "waitingDate": "2018-11-12T10:49:03.017Z"
  }
}
```

## Get status and raw data by RefID

```js
curl -X GET \
  https://<DASHBOARD_URL>/kyc/1.0/connect/<CLIENT_ID>/refId/<REFID> \
  -H 'Authorization: <API_KEY>' \
  -H 'cache-control: no-cache'
```

returns

```json
{
  "status": "success",
  "data": {
    "status": "inreview",
    "refId": "1",
    "isArchived": false,
    "blockPassID": "5be95a995f8c44000e972445",
    "inreviewDate": "2018-11-12T10:49:17.973Z",
    "waitingDate": "2018-11-12T10:49:03.017Z",
    "identities": {
      "address": {
        "type": "string",
        "value": "{\"postalCode\":\"62576-6471\",\"city\":\"Luettgenchester\",\"address\":\"4611 Zieme Knoll\",\"extraInfo\":\"extra\",\"country\":\"VNM\",\"state\":\"\"}"
      },
      "dob": {
        "type": "string",
        "value": "12/31/2016"
      },
      "email": {
        "type": "string",
        "value": "52777-50830-Alexandre42@yahoo.com"
      },
      "family_name": {
        "type": "string",
        "value": "StromanBot"
      },
      "given_name": {
        "type": "string",
        "value": "Helmer"
      },
      "phone": {
        "type": "string",
        "value": "{\"countryCode\":\"VNM\",\"countryCode2\":\"vn\",\"phoneNumber\":\"+84987543212\",\"number\":\"987543212\"}"
      },
      "selfie_national_id": {
        "type": "base64",
        "value": "/9j/4AAQSkZJRgABAQEASABIAAD/<...>"
      },
      "proof_of_address": {
        "type": "base64",
        "value": "/9j/4AAQSkZJRgABAQEASABI<...>"
      },
      "selfie": {
        "type": "base64",
        "value": "/9j/4AAQSkZJRgABAQEA<...>"
      },
      "passport": {
        "type": "base64",
        "value": "/9j/4AAQSkZJ<...>"
      }
    },
    "certs": {
      "onfido-service-cert": "{\"@context\":[{\"@version\":1.1},,<...>",
      "complyadvantage-service-cert": "{\"@context\":[{\"@version\":1.1},<...>"
    }
  }
}
```

## Encryption

To protect users data we highly recommend merchants to use an encryption key to secure raw data transfer

### Principle

- Server generates an RSA key pair and share public key with merchant
- Merchant generates AES key and encrypt with RSA public key (EK)
- To query raw data with API, (EK) must be attached.
- Server returns the encrypted data

> :point_right: contact us for additional information

## Auto-archive local data after API extraction (v1.7+)

From KYC Connect `v1.7`, API supports auto-archive KYC attributes after X seconds

* leave empty or set to 0 to disable auto-archive)
* 10 sec recommended  

![Export config](/docs/kyc-connect-dashboard/imgs/Archive-ApiKey.png)

Example:

```js
curl -X GET \
  https://<DASHBOARD_URL>/kyc/1.0/connect/<CLIENT_ID>/refId/<REFID> \
  -H 'Authorization: <API_KEY>' \
  -H 'cache-control: no-cache'
```

returns record with `willArchiveAtDate`

```json
{
  "status": "success",
  "data": {
    "status": "approved",
    "refId": "5",
    "isArchived": false,
    "willArchiveAtDate": "2019-04-01T10:49:03.017Z",
    ....
    "identities": {
      ...
    }
  }
}
```

after `willArchiveAtDate` happens,  running the query again will return `isArchived` set to **true** and no `identities` (raw data was deleted)

Example with `willArchiveAtDate` and `isArchived` set to true:

```json
{
  "status": "success",
  "data": {
    "status": "approved",
    "refId": "5",
    "isArchived": true,
    "willArchiveAtDate": "2019-04-01T10:49:03.017Z",
    ....
  }
}
```
