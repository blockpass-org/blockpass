# Multiple dashboards

Merchants can use the same docker install to host multiple dashboards and QR codes. 

- Create 2 or more services in the Blockpass Developer Portal
- Generate a STANDALONE_CONFIG parameter based on the services you have created
  - In the list of service, select one or more services
  - Click the button `Export Services config`
  - Copy the string generated

![Export config](/docs/kyc-connect-dashboard/imgs/Multiple-dashboard-config.png)

- Run the installation script and provide the STANDALONE_CONFIG generated above (see [install instructions](./dashboard-home.md))
- Once installation is finished, create reviewers accounts and assign them to one or more dashboards.
