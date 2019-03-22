# Nginx configuration

_You need enable HTTPS/SSL during instalation before following instruction below_

- KYCConnect work behind nginx instance and it can fully configurable by modify `nginx.conf`

- With default nginx allow access all KYC connect endpoints

```sh
  location / {
        proxy_pass http://web;
        proxy_set_header Host ${HOST_NAME};
    }
```

## Important Routes

- `/kyc/1.0/sdk/endpoint/*`: Using for mobile app communication (upload data, check status)

- `/kyc/1.0/connect/*`: Using for [Data extraction](./endpoints.md)

## Use case 1 - Restricted IP for dashboard access

- Usecase:

  Default config is too open( Dashboard can be access via public internet). Our expectations:

  - Dashboard can only access via Some IP
  - Blockpass mobile application can communication with KYCConnect without blocked

- Nginx config:

```sh
    # Mobile application endpoints
    location /kyc/1.0/sdk/endpoint/ {
        proxy_pass http://web;
        proxy_set_header Host ${HOST_NAME};
    }

    # Only Allow xxx.yyy.zz.k access dashboard
    location / {
        proxy_pass http://web;
        allow xxx.yyy.zz.k;
        deny all;
    }
```

- Restart service to apply new config

```sh
docker-compose restart
```
