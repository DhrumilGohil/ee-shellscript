#! /bin/bash

date_diff_in_days() {
	site_date=$1
	formatted_site_date=$(echo "$site_date" | awk -F'/' '{print $2" "$1" "$3}')
        converted_site_date=$(date -d "$formatted_site_date" +"%Y/%m/%d")
        current_date=$(date +"%Y/%m/%d")
        site_epoch=$(date -d "$converted_site_date" +"%s")
        current_epoch=$(date -d "$current_date" +"%s")
        time_diff=$((current_epoch - site_epoch))
        days_diff=$((time_diff / 86400))
        echo "$days_diff"

}

echo "List of sites not access since 30 days" > ~/site_list.txt
EE_DIR=/opt/easyengine/sites/
LOG_PATH=logs/nginx/access.log
cd $EE_DIR
for site in * ; do
#	echo "$site"
	site_date=$(cat $site/$LOG_PATH | tail -n 1 | awk '{print $4}'| cut -d':' -f1 | tr -d '[')
	days_diff=$(date_diff_in_days "$site_date")
	if [ "$days_diff" -gt 30 ]; then
		sitename=$(basename "$site")
		echo "$sitename" >> ~/site_list.txt
	fi
done

send_slack_noti()
{
	site_list=$(cat ~/site_list.txt)
	PAYLOAD=$(cat <<EOF
	{
  		"text": "$site_list"
	}
EOF
)
	echo "$site_list"

	curl -X POST -H 'Content-type: application/json' --data "$PAYLOAD" https://hooks.slack.com/services/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
}

send_slack_noti

