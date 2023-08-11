#! /bin/bash
while true; do
    echo -n "Enter Easyengine Wordpress SiteName tp restore (or 'exit' to quit): "
    read sitename

    if [ "$sitename" == "exit" ]; then
        echo "Exiting..."
        break
    fi
echo "$sitename"



EE_DIR_PATH="/opt/easyengine/sites/$sitename"
DRIVE_DIR=gdocs://dhrumil.gohil@rtcamp.com/duplicity
GPG_ID=2349166A7DE7FCC0537CEDA47A335E00B8E26D91

echo "Checking..."
if [ -d $EE_DIR_PATH ]; then
        echo "$sitename site found"
	echo "Backup in progress..."
	if [ -d ${EE_DIR_PATH}/app/htdocs ]; then
	       	rm -r ${EE_DIR_PATH}/app/htdocsi
	fi
	GOOGLE_DRIVE_SETTINGS=~/.duplicity/credentials duplicity restore --file-to-restore /code/htdocs/ "${DRIVE_DIR}/${sitename}_backup" ${EE_DIR_PATH}/app/htdocs
	
	GOOGLE_DRIVE_SETTINGS=~/.duplicity/credentials duplicity restore --file-to-restore /db/  "${DRIVE_DIR}/${sitename}_backup" ${EE_DIR_PATH}/app/htdocs/db_backup
	
	echo "Import Database..."
	ee shell $sitename --command='wp db import db_backup/db_backup.sql'
	rm -r ${EE_DIR_PATH}/app/htdocs/db_backup
else 
	echo "Opps! Site not found"
fi

done
