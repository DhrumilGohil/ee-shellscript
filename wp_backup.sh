#! /bin/bash

BACKUP_DIR=~/backup
EE_DIR=/opt/easyengine/sites/
DATE=$(date +%Y%m%d%H%M%S)
mkdir -p $BACKUP_DIR
rclone mkdir WP-backup
for site in $(ls $EE_DIR); do
#       echo $site
        check=$(ee site info "$site" | grep -i "WordPress")
        if [ ! -z "$check" ]; then
                echo "Starting WordPress EasyEngine backup for ${site}"
                echo "---------------------------------------------"

                sitedir=$EE_DIR/$site
		SNAPSHOT=${BACKUP_DIR}/${site}_snapshot.snar
		touch  $SNAPSHOT

                echo "Backing up code and uploads..."
                # backup wp code and upload
                mkdir -p $BACKUP_DIR/${site}_tmp
                mkdir -p $BACKUP_DIR/${site}_tmp/code
                rsync -a  ${sitedir}/app/htdocs $BACKUP_DIR/${site}_tmp/code

                echo "Backing up MySQL databases..."
                # export db
                ee shell $site --command='wp db export db_backup.sql'

                mkdir -p $BACKUP_DIR/${site}_tmp/db
                rsync -a ${sitedir}/app/htdocs/db_backup.sql $BACKUP_DIR/${site}_tmp/db
                rm ${sitedir}/app/htdocs/db_backup.sql

                if [ ! -f "$BACKUP_DIR/${site}_full_backup.tar.gz"  ]; then
			backup_file="$BACKUP_DIR/${site}_full_backup.tar.gz"
			tar -czf "$backup_file" --listed-incremental="$SNAPSHOT"  -C "${BACKUP_DIR}/${site}_tmp/" .
		else
			backup_file="$BACKUP_DIR/${site}_increment_${DATE}.tar.gz"
			tar -czf "$backup_file" --listed-incremental="$SNAPSHOT"  -C "${BACKUP_DIR}/${site}_tmp/" .
		fi

               # rm -r "${BACKUP_DIR}/${site}_tmp"
                #rm "$backup_file"
        fi
done

rclone copy "${BACKUP_DIR}/" google-remote:WP-backup
#delete directory
#rm -r $BACKUP_DIR

# Delete all the backups older than 7 days
find "${BACKUP_DIR}" -type f -name "*.tar.gz" -ctime +7 -exec rm -r {} \;

# NOTE I have also added below line cron to take Backup at 2 AM everyday
# 0 2 * * * ~/ee-ss-task/wp_backup.sh
