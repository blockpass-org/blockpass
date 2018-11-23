# How to config your service endpoints

- Login to Blockpass Developer Portal

> :point_right: contact us to get url and credentials

- Select your service detail -> Advanced

- Update/Create configuration

![ServiceEndpoints](/docs/kyc-connect-dashboard/imgs/ServiceEndpoints.png)

- Update `Endpoints` link with:

  - endpoint_status:  
    `${HOST_NAME}/kyc/1.0/sdk/endpoint/formpass_3/status`
  - endpoint_login:  
    `${HOST_NAME}/kyc/1.0/sdk/endpoint/formpass_3/login`
  - endpoint_register:  
    `${HOST_NAME}/kyc/1.0/sdk/endpoint/formpass_3/register`
  - endpoint_upload:  
    `${HOST_NAME}/kyc/1.0/sdk/endpoint/formpass_3/uploadData`
  - endpoint_resubmit:  
    `${HOST_NAME}/kyc/1.0/sdk/endpoint/formpass_3/resubmit`
