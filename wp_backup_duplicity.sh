#! /bin/bash

BACKUP_DIR=~/backup
EE_DIR=/opt/easyengine/sites/
mkdir -p $BACKUP_DIR
for site in $(ls $EE_DIR); do
#       echo $site
        check=$(ee site info "$site" | grep -i "WordPress")
        if [ ! -z "$check" ]; then
                echo "Starting WordPress EasyEngine backup for ${site}"
                echo "---------------------------------------------"
		site_bakup_dir=${BACKUP_DIR}/${site}
		mkdir -p $site_bakup_dir
		PASSPHRASE="" duplicity  --encrypt-key=2349166A7DE7FCC0537CEDA47A335E00B8E26D91 "${EE_DIR}/${site}/app/htdocs" "file://${site_bakup_dir}"
	fi
done
