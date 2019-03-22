# Nginx configuration

_You need to enable HTTPS/SSL during installation before following instructions below_

- KYC Connect works behind nginx server and it can configured by modifying the `nginx.conf` file

- By default nginx allows access to all KYC Connect endpoints and login form

```sh
  location / {
        proxy_pass http://web;
        proxy_set_header Host ${HOST_NAME};
    }
```

## Important Routes

- `/kyc/1.0/sdk/endpoint/*`: Used by mobile app to communicate with the dashboard (upload data, check status)

- `/kyc/1.0/connect/*`: Used for [Data extraction](./endpoints.md)

## Use case - Restrict dashboard access by IP

- Use case:

  Default config is open to the world (Dashboard can be access via internet). Goal:

  - Dashboard can only be accessed by specific IPs
  - Blockpass mobile application can still communicate with KYC Connect without being blocked

- Nginx config:

```sh
    # Mobile application endpoints
    location /kyc/1.0/sdk/endpoint/ {
        proxy_pass http://web;
        proxy_set_header Host ${HOST_NAME};
    }

    # Only Allow xxx.yyy.zz.k IP to access the dashboard
    location / {
        proxy_pass http://web;
        allow xxx.yyy.zz.k;
        deny all;
    }
```

- Restart service to apply the new config

```sh
docker-compose restart
```
