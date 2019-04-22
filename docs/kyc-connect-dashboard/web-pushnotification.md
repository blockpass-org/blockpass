# Web Push Notification configuration

_You need to enable HTTPS/SSL during installation before following instructions below_

- Values below can be set during fresh installation or added manually in `docker-compose.yaml` (for an existing installation)

  - `PN_GOOGLE_API_KEY`  
    Push notifications API key  
    You can get the key from [Google Firebase Console](https://console.firebase.google.com). Follow intructions [here](https://developer.clevertap.com/docs/find-your-fcm-sender-id-fcm-server-api-key#)

  - `PN_PUBLIC_VAPID_KEY`  
    Google VAPID public key. Follow instructions [here](https://developers.google.com/web/ilt/pwa/introduction-to-push-notifications#using_vapid) or [codelab online tool](https://web-push-codelab.glitch.me/)

  - `PN_PRIVATE_VAPID_KEY`  
    Google VAPID secret key. Follow instructions [here](https://developers.google.com/web/ilt/pwa/introduction-to-push-notifications#using_vapid) or [codelab online tool](https://web-push-codelab.glitch.me/)

## New registration in KYC Connect

- Use case:  
  Every X minutes, send a notification if a new registration is received in the dasbboard 

![New Registration](/docs/kyc-connect-dashboard/imgs/PN-new-register.png)

- Configuration:  
  Open `docker-compose.yaml`, add new key under `environment` section
  - NOTICE_NEW_REGISTRATION_INTERVAL_MS: reporting interval in millisecond (recommended value: 1800000ms=30 mins)

  Example
  ```sh
  environment:
   - NOTICE_NEW_REGISTRATION_INTERVAL_MS=1800000
  ```

- Restart service to apply the new config

  ```sh
  docker-compose restart
  ```
