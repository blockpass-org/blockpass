# How to config Certificate for your service

- Login to Blockpass Developer Portal

  - Staging: [https://developer-sandbox.blockpass.org](https://developer-sandbox.blockpass.org)
  - Production: [https://developer.blockpass.org](https://developer.blockpass.org)

- Select your service detail -> **CERTIFICATES**

- Add new Certificate

![AddCertificate](/docs/kyc-connect-dashboard/imgs/AddCertificate.png)

- Create Bitcoin Private key for signing certificate. With some methods below:

  - Using your own tool if you have to generate `Private key` and `Compressed Bitcoin Address`
  - Online tool [https://www.bitaddress.org/](https://www.bitaddress.org/) (We recommend use offline version following introduction [here](https://bitcoin.stackexchange.com/questions/22115/how-to-download-bitaddress-org-to-use-offline))
  - Use `OpenSSL` to generate key pair and online tool to get Bitcoin Compressed address [sh-script](/docs/kyc-connect-dashboard/cerKeyGen.sh)

- Update your `Compressed Bitcoin Address` as public key into service **BasicInfo**
  ![UpdatePubKey](/docs/kyc-connect-dashboard/imgs/ServicePubKey.png)
