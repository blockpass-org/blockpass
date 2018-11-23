# How to get your Widget Code

The widget displays a QR Code that Blockpass users can scan with their mobile application to register/login your service.

- Login to Blockpass Developer Portal

  - Staging: [https://developer-sandbox.blockpass.org](https://developer-sandbox.blockpass.org)
  - Production: [https://developer.blockpass.org](https://developer.blockpass.org)

- Select your service detail

- At the bottom of the page, press on `Code Button`.  
  A popup will show your service's Widget code

![WidgetCode](/docs/kyc-connect-dashboard/imgs/WidgetCode.png)

- Paste the code to an html page

Example:

```html
<html>

<head>
</head>

<body>
  <!-- Code Here -->
  <!-- BLOCKPASS WIDGET SCRIPT BEGIN-->
<script>(function () {
    const s = document.createElement('script');
    s.src = 'https://cdn.blockpass.org/widget/scripts/release/1.0.1/embeded.prod.js';
    s.async = true;
    window.bpWidget = {
      // replace by environment
      env: 'staging',

      // ClientId
      clientId: 'formpass_3',

      // ServiceName (display on button)
      serviceName: 'Formpass Demo1',

      // IMPORTANT: replace with your referral ID
      refId: 'ref-id-here:' + Date.now(),

      onSSOComplete: result => {
        //Todo: Put your logic here
      }
    };
    document.body.appendChild(s);
  })();
</script>
<div id="widget-bp123" />
  <!-- BLOCKPASS WIDGET SCRIPT END-->

</body>

</html>
```
