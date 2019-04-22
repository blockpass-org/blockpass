# Blockpass CLI

## Stop the service

`./blockpass stop`

## Start/restart the service

`./blockpass start`

## Display the logs

`./blockpass logs`

## Ugrade version

While server is running, run:

`./blockpass upgrade`

Confirm and choose the version you want to install.
Ex: `latest` or `1.8.1`

> :point_right: List of versions + change logs can be found here [Docker Hub](https://hub.docker.com/r/blockpass/kyc-connect/tags)

Corresponding images will be downloading, server is still up during this operation.
When images are downloaded, server will restart to apply the new version (usually takes few seconds).

> :point_right: It is a good idea to make a backup of database before upgrading (see [Backup](./backup.md) section)
