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
		
		code_dir=${BAKUP_DIR}/${site}/code
		db_dir=${BAKUP_DIR}/${site}/db
		mkdir -p $code_dir
		mkdir -p $db_dir

		cp -r ${EE_DIR}/${site}/app/htdocs $code_dir

		# export db
                ee shell $site --command='wp db export db_backup.sql'

		cp ${EE_DIR}/${site}/app/htdocs/db_backup.sql $db_dir
			
		GOOGLE_DRIVE_SETTINGS=~/.duplicity/credentials duplicity --encrypt-key 2349166A7DE7FCC0537CEDA47A335E00B8E26D91  ${BAKUP_DIR}/${site}/ gdocs://dhrumil.gohil@rtcamp.com/duplicity/${site}_backup
        fi
done
