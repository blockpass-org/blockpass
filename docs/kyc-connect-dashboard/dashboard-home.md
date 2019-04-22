# KYC Connect Installation

## Before you begin

Make sure you have installed Docker (v18+) and DockerCompose (1.22+)

## Run the installation

Paste the following script in your terminal and follow the instructions:

```
bash <(curl -s 'https://cdn.blockpass.org/kyc-connect/install.sh')
```

Refer to [this guide](./installation-script.md) if you are unsure how to use the installation script.

- Open Web browser using the chosen address (ex: https://my-domain.com).

At first launch, you will be asked to input the `Deployment key` (the one you have just chosen during the installation) and choose a password for the `admin` account.

![Step0](/docs/kyc-connect-dashboard/imgs/Step0.png)

- Login using `admin` account to access Administrator Page

![Step1](/docs/kyc-connect-dashboard/imgs/Step1.png)

`You're good to go!!! 🎉`

## What's next?

- [Create a reviewer](./create-reviewer.md)
- [Setup the widget](./widget.md)
- [Stop/Start/Logs KYC Connect](./cli.md)
- [Config your endpoints](./endpoints.md)
- [Upgrade/Change version](./cli.md)
- [Multiple dashboards](./multiple-dashboards.md)
- [Generate a Certificate](./certificate.md)
- [Extract data by API](./api.md)
- [Nginx - Restrict access to dashboard by IP](./nginx-config.md)
- [Web push-notification configuration](./web-pushnotification.md)
