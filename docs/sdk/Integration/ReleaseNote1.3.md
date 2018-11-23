<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [ReleaseNote1.3](#releasenote13)
  - [Blockpass Mobile 1.3](#blockpass-mobile-13)
    - [Mobile App changelog](#mobile-app-changelog)
  - [SDK changelog](#sdk-changelog)
    - [Endpoint /resubmit (new features)](#endpoint-resubmit-new-features)
    - [Steps to upgrade a NodeJS integration](#steps-to-upgrade-a-nodejs-integration)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# ReleaseNote1.3

## Blockpass Mobile 1.3

### Mobile App changelog

- Changes in `country` KYC field: change from using country name to 3-letters country code. [moreinfo](/docs/sdk/SpecV1/Server_Spec_V1.md#311-address-json-format-v13)
```js  
// [old format]: JSON string
{"address":"Oili","extraInfo":"Kos","city":"Oakbc","state":"CO","postalCode":"99999","country":"United States"}

// [new format]: JSON string 
{"address":"Street","extraInfo":"Addition info","city":"City","state":"AL","postalCode":"700000","country":"USA"}
```
- Changes in `phone` KYC field: phone number will be sent along with the country codes that the number belongs to.
[moreinfo](/docs/sdk/SpecV1/Server_Spec_V1.md#312-phone-json-format-v13)

```js
// [old format]: string containing phone number
3686656494

// [new format]: JSON string containing phone number data
{"countryCode":"VNM","countryCode2":"vn","phoneNumber":"+84987543212","number":"987543212"}
```
- Update on UI:
    - User will be able to see list of registered Services, allow him/her to quickly view the status / progress of his registration
<img src="Services/img/1.3.service_screen.jpg" alt="Registed services are display in the home screen for quick access" width="320"/>

    - Improve UI on KYC address screen
<img src="Services/img/1.3.new_address_ui.jpg" alt="KYC Address screen is improved for better UX" width="320"/>

    - Improve UI on KYC phone screen
<img src="Services/img/1.3.new_phone_ui.jpg" alt="KYC Phone screen is improved for better UX" width="320"/>
<img src="Services/img/1.3.new_phone_ui_2.jpg" alt="KYC Phone screen is improved for better UX" width="320"/>

    - Resubmit data to service
<img src="Services/img/1.3.service_resubmit.jpg" alt="Resubmit data to service" width="320"/>


## SDK changelog

### Endpoint /resubmit (new features)

Mobile App version 1.3 auto detects changes in User identity fields and show a *Resubmit* button that let user update those changes to Services. In order to enable this features. On server side it should:
- Add a new endpoint `/resubmit`.
- Add new flag in `KycRecordStatus`: `allowResubmit` ([more detail](/docs/sdk/Server_Spec_V1.md#1-kycrecordstatus)). Service can return `false` OR not return this field at all (If Service doesn't care about changes in user data).
- (More detail for [/resubmit](/docs/sdk/SpecV1/Server_Spec_V1.md#4-resubmit))

### Steps to upgrade a NodeJS integration

- Get the latest version of the [Javascript Server SDK (1.3)](https://github.com/blockpass-org/blockpass-serversdk/releases/tag/v1.3) (example included)

- Implement new endpoint `/resubmit`

``` javascript
router.post('/blockpass/api/resubmit', async (req, res) => {
    try {
        const { code, fieldList, certList } = req.body

        const payload = await serverSdk.resubmitDataFlow({ code, fieldList, certList })
        return res.json(payload)
    } catch (ex) {
        console.error(ex)
        return res.status(500).json({
            err: 500,
            msg: ex.message,
        })
    }
})
```