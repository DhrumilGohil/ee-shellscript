# ee-shellscript-task

## The task is to create shell script file which will scan all easyengine site on server and find the all the sites which haven't access since 30 days.
## Then send the file list to the slack app.

scipt.sh
```
https://github.com/DhrumilGohil/ee-shellscript/blob/main/script.sh
```
## For Sending Notification to slack.
We need to create new workspace.

- Go to https://slack.com/intl/en-in/help/articles/206845317-Create-a-Slack-workspace. Create your workspace.
- Now, We need to create webhook for the our slack app.
- Create new Incoming Webhook for the app.
<img width="722" alt="Screenshot 2023-08-10 at 1 59 57 PM" src="https://github.com/DhrumilGohil/ee-shellscript/assets/57474739/fc0a19b3-ceba-4077-a2c7-4a08c10f6ee5">

- Add new webhook for app
<img width="737" alt="Screenshot 2023-08-10 at 2 00 55 PM" src="https://github.com/DhrumilGohil/ee-shellscript/assets/57474739/d7d3ece8-bfb0-47f2-aa01-dad4a60a8480">

- Select channel, You want to send notification.
<img width="660" alt="Screenshot 2023-08-10 at 2 01 27 PM" src="https://github.com/DhrumilGohil/ee-shellscript/assets/57474739/dd56f5fc-bbe0-45c9-9f72-0d24cd29db29">

- Copy your webhook's URL
  ```
  curl -X POST -H 'Content-type: application/json' --data "$PAYLOAD" https://hooks.slack.com/services/T05M6CH583C/B05LRSSTB0X/********
  ```
- Once you execute this You will get notification.
  <img width="518" alt="Screenshot 2023-08-10 at 2 06 04 PM" src="https://github.com/DhrumilGohil/ee-shellscript/assets/57474739/4ca9378b-5220-4309-9b77-25adbc0d17d8">

