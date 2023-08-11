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
echo "Checking..."
DRIVE_DIR=gdocs://dhrumil.gohil@rtcamp.com/duplicity
if [ -d $EE_DIR_PATH ]; then
        echo "$sitename site found"
	echo "Backup in progress..."
GOOGLE_DRIVE_SETTINGS=~/.duplicity/credentials duplicity restore --file-to-restore /code/htdocs/ "${DRIVE_DIR}/${sitename}_backup" ${EE_DIR_PATH}/app/htdocs

GOOGLE_DRIVE_SETTINGS=~/.duplicity/credentials duplicity restore --file-to-restore /db  "${DRIVE_DIR}/${sitename}_backup" ${EE_DIR_PATH}/app/htdocs/db_file

else 
	echo "Opps! Site not found"
fi

done
