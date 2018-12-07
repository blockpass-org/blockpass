# Test Blockpass KYC Connect Dashboard

Test our KYC Connect Dashboard before installation

## A. Install Blockpass Staging mobile application

Download blockpass mobile application (staging version) from

- `Testflight`: to test with an iPhone  
  Click here to download the staging app: https://testflight.apple.com/join/JavudHsa

- `Google Play`: to test with an Android  
  Click here to download the staging app: https://play.google.com/apps/testing/com.blockpass_mobile.staging

## B. Create Blockpass identity

Once the mobile app is installed, create a 'fake' identity  
(Icon of the staging version is dark grey)

### 1. Get a KYC certificate

Required fields

- name
- DoB
- Passport
- Phone number

Submit to Passport Authentication verifier.

Notes:

- Checks are not real. Results are always the same whatever data are submitted.
- Please do not submit real passport picture.
- You can upload any picture but it must include at least a face (otherwise it will get rejected).

### 2. Get a AML certificate

Required

- Name
- DoB

Submit to Sanction List and PEP check verifier

## C. QR code scanning

Once both certificates are received, on your desktop, go to this url to access the QR code

> :point_right: contact us to get clientId and serviceName

https://demo.blockpass.org/?clientId=#####&serviceName=#####&env=staging

Scan the QR code and follow instructions  
Currently all identity fields and 2 certificates are required to register.  
This is configurable

## D. Review registrations

Once registration is done, go to the dashboard url to review profiles

> :point_right: contact us to get dashboard url and login credentials

## E. Data export

### 1. Simple local export

When a profile is approved, operator can export the profile locally in a zip file.
It is also possible to batch export all approved data

### 2. APIs

We offer 2 types of APIs

- Query profile' status by User ID  
  This API returns only status of a profile. No personal data

- Query full profiles by Used ID  
  This API returns all personal data submitted to the service  
  The client must provide a cryptographic key to encrypt the personal data when using this API

> :point_right: contact us for more information about our APIs
