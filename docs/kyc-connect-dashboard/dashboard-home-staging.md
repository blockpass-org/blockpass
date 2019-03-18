# Test Blockpass KYC Connect Dashboard


Test our KYC Connect Dashboard before installation

## A. Install Blockpass Staging mobile application

Download blockpass mobile application (staging version) from

* `Testflight`: to test with an iPhone  
  Open this link in Safari iPhone to join test app in Testflight:  https://testflight.apple.com/join/JavudHsa

* `Google Play`: to test with an Android  
Click here to download the staging app: https://play.google.com/apps/testing/com.blockpass_mobile.staging 


## B. Create Blockpass identity
Once the mobile app is installed, create a 'fake' identity  
(Icon of the staging version is dark grey)

### 1. Get a KYC certificate 
Required fields
- name
- DoB
- Passport

Submit to Passport Authentication verifier.

Notes:   
- Checks are not real. Results are always the same whatever data are submitted.  
- Please do not submit real passport picture.  


### 2. Get a AML certificate
Required 
- Name
- DoB

Submit to Sanction List and PEP check verifier

### 3. Get a Face Match certificate

Required 
- Passport
- Selfie

Submit to Face Match verifier


## C. QR code scanning

Once both certificates are received, on your desktop, go to this url to access the QR code

> :point_right: contact us to get clientId and serviceName

https://demo.blockpass.org/?clientId=#####&serviceName=#####&env=staging

Scan the QR code and follow instructions  
Currently all identity fields and 3 certificates are required to register.  
This is configurable 

## D. Review registrations

Once registration is done, go to the dashboard url to review profiles

> :point_right: contact us to get dashboard url and login credentials


## E. Data export

### 1. Simple local export

When a profile is approved, operator can export the profile locally in a zip file.
It is also possible to batch export all approved data


### 2. APIs

See our API documentation
https://github.com/blockpass-org/blockpass/blob/master/docs/kyc-connect-dashboard/api.md


