#KYC Connect installation script guide

- Host and port:

  - `Hostname`
    Hostname binding to this service  
    ex: `your-domain.com`

  - `Port`  
    Service Port (on the host system)  
    ex: 443

- Blockpass configurations:

  - `Environment`  
    Blockpass environment: `prod` or `staging`  
    ex: prod

  - `Deployment key`  
    Choose a secret key that will be used during first setup and for recovery  
    ex: u6A8hhdg

  - `Standalone configuration`  
    Auto configuration string that you can get from the Developer Portal.  
    Follow instructions [here](./kyc-config.md) to get the parameter.

    It includes your `service name`, your `clientId`, your `clientSecret`, the `status` of the service (active or inactive) and the `images` paths your have configured.

- HTTPS / SSL

  If you already have your own https proxy (ex: Nginx) you can skip this by typing `No`.

  But if you want to host the solution using HTTPS/SSL press Enter and it will ask for your public/private keys.

  - `SSL Certificate` of your domain.

    Paste the content of certificate file. It usually starts with "-----BEGIN CERTIFICATE-----" and ends with "-----END CERTIFICATE-----"

    It should probably contain multiple certificates (Primary - Intermediate - Root)

  - `Private key`  
    The private key for the SSL certificate of your domain.

    Paste the content of the key. It usually starts with "-----BEGIN RSA PRIVATE KEY-----" and ends with "-----END RSA PRIVATE KEY-----"

## Advanced setup: [Optional]

- Customize the `docker-compose.yaml` to your needs

- Google Web push notification :

  If you need Push notification, make sure you declare the following environment variables.

  (Don't forget to restart KYC Connect using ./blockpass start if it was already running)

  - `PN_GOOGLE_API_KEY`  
    Push notifications API key  
    You can get it from [Google Firebase Console](https://console.firebase.google.com). Follow intructions [here](https://developer.clevertap.com/docs/find-your-fcm-sender-id-fcm-server-api-key#)

  - `PN_PUBLIC_VAPID_KEY`  
    Google VAPID public key. Follow instructions [here](https://developers.google.com/web/ilt/pwa/introduction-to-push-notifications#using_vapid) or [codelab online tool](https://web-push-codelab.glitch.me/)

  - `PN_PRIVATE_VAPID_KEY`  
    Google VAPID secret key. Follow instructions [here](https://developers.google.com/web/ilt/pwa/introduction-to-push-notifications#using_vapid) or [codelab online tool](https://web-push-codelab.glitch.me/)

- Certificate

  After a KYC profile is approved, the reviewer can issue a `certificate` to user

  Certificate is digital document formatted as [json-ld](https://w3c-dvcg.github.io/ld-signatures/) and signed with ECDSA (Bitcoin key)

  To configure a certicate, some extra settings are required on the `Developer Portal` [Guide Here](./certificate.md)

  To issue certificates, you need a ECDSA Key pair

  - `Public WIF Key(Bitcoin address)` your Bitcoin Address as public key

  - `Private WIF Key(Bitcoin private key formated as WIF Compressed)` your Bitcoin private key formatted as WIF Compressed
