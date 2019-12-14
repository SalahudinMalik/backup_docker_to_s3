
#!/bin/sh -       
#title           :backup_docker_to_s3.sh
#description     :This script is creating a Docker Backup through backup-docker tool,
#                tar and compress the backup file via lzo algorithm compression, and upload it to AWS S3.
#author		     :Salahudin <salahudiniiui@gmail.com>
#date            :2019-11-25
#version         :1.0
#usage		     :sh backup_docker_to_s3.sh container_name | eg. sh backup_docker_to_s3.sh test_container123
#dependencies    : npm install -g backup-docker && apt-get update && apt-get install lzop && apt-get install s3cmd.
#==============================================================================


TODAY=$(date +%Y-%m-%d)

CONTAINER=$1 # container name from terminal argument

#folder in which we'll move our volumes and containers folder
BACKUP="docker_backup"

# aws bucket 
AWS_BUCKET="aws_bucket"



echo "backup container $1 on date $TODAY"
backup-docker backup $CONTAINER


if [ -d "$BACKUP" ]; then rm -Rf $BACKUP; fi

# create a backup folder
mkdir $BACKUP
echo "created backup folder with name $BACKUP"

# move backup folders to main backup folder 
mv ./containers ./$BACKUP
mv ./volumes ./$BACKUP
echo "moved containers and volumes to $BACKUP folder"

# tar folder

tar -cvf $BACKUP-$CONTAINER-$TODAY.tar.gz $BACKUP --remove-files

# Compress TAR File with lzo algorithm

lzop $BACKUP-$CONTAINER-$TODAY.tar.gz -U

echo "backup file created with name : $BACKUP-$CONTAINER-$TODAY.tar.gz"

s3cmd   put   --recursive   $BACKUP-$CONTAINER-$TODAY.tar.gz.lzo   $AWS_BUCKET

echo "moved file to s3"

# deleting file from system
rm $BACKUP-$CONTAINER-$TODAY.tar.gz.lzo

echo "removed backup file after moving to s3"
