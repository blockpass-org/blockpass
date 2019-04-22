# Web push-notification configuration

_You need to enable HTTPS/SSL during installation before following instructions below_

- Those values below must be set during instalation script (new install) or open and modify `docker-compose.yaml` ( existing installation)

  - `PN_GOOGLE_API_KEY`  
    Push notifications API key  
    You can get it from [Google Firebase Console](https://console.firebase.google.com). Follow intructions [here](https://developer.clevertap.com/docs/find-your-fcm-sender-id-fcm-server-api-key#)

  - `PN_PUBLIC_VAPID_KEY`  
    Google VAPID public key. Follow instructions [here](https://developers.google.com/web/ilt/pwa/introduction-to-push-notifications#using_vapid) or [codelab online tool](https://web-push-codelab.glitch.me/)

  - `PN_PRIVATE_VAPID_KEY`  
    Google VAPID secret key. Follow instructions [here](https://developers.google.com/web/ilt/pwa/introduction-to-push-notifications#using_vapid) or [codelab online tool](https://web-push-codelab.glitch.me/)

## Enable - Notice new registration

- Use case:
  Notice new registration (if has any) every interval

![New Registration](/docs/kyc-connect-dashboard/imgs/PN-new-register.png)

- Configuration:
  Open `docker-compose.yaml` add new key under `environment:` sections
  - NOTICE_NEW_REGISTRATION_INTERVAL_MS: reporting interval (recomended value 1800000 ms - 30 mins)

```sh
    environment:
      - NOTICE_NEW_REGISTRATION_INTERVAL_MS=<miliseconds>
```

- Restart service to apply the new config

```sh
docker-compose restart
```
