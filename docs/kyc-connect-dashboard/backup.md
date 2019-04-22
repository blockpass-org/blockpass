# Backup KYC Connect data

## Automated backup

To backup mongoDB while server is running, it is required to use `mongodump` utility

* Go to KYC Connect install folder
* Get the name of the mongodb container  
  `docker ps`  
   ex: kycconnect_mongodb.ins_1
* SSH in container  
  `docker exec -it kycconnect_mongodb.ins_1 bash`
* Go to data folder and create backup folder  
  `cd /data/db`  
  `mkdir backup`  
  `cd backup`
* Dump database   
  `mongodump`

Now exit the container and copy the backup folder locally  
`docker cp formpass_mongodb.ins_1:/data/db/backup . `


## Manual backup

* Go to KYC Connect install folder
* Make sure the server is not running  
  `docker-compose stop`
* Duplicate database folder  
  `cp -R mongo mongo-backup`


## Links

*  [mongoDB documentation](https://docs.mongodb.com/manual/core/backups/#back-up-with-cp-or-rsync)