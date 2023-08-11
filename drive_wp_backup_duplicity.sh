#! /bin/bash

EE_DIR=/opt/easyengine/sites/
for site in $(ls $EE_DIR); do
#       echo $site
        check=$(ee site info "$site" | grep -i "WordPress")
        if [ ! -z "$check" ]; then
                echo "Starting WordPress EasyEngine backup for ${site}"
                echo "---------------------------------------------"
		
		GOOGLE_DRIVE_SETTINGS=~/.duplicity/credentials duplicity --encrypt-key 2349166A7DE7FCC0537CEDA47A335E00B8E26D91  ~/test/ gdocs://dhrumil.gohil@rtcamp.com/duplicity
        fi
done
