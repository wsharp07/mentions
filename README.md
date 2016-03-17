# README

[![Build Status](https://travis-ci.org/ppworks/mentions.svg?branch=master)](https://travis-ci.org/ppworks/mentions)

If you've mentioned on github, you'll get mention on slack.

## Setup

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

or

```
export MENTIONS_MAPPING_FILE_PATH=https://gist.githubusercontent.com/ppworks/49f6ce44efb09d5fc8e9/raw/c1465aab5d6604b98ba6ca4c31263a5b36f62378/mention_mappings.yml # mapping file path
export SLACK_WEBHOOK_URL=https://hook.slack.com/services/yyyyyyyyyyyyyy # Please use Incoming WebHooks
```

### Create webhook

Now, we support from github to slack & esa to slack.

### Set GitHub webhook

```
heroku run console -a your-application-name
Webhook.create(from: 'github', to: 'slack').token # Your webhook token
```

```
https://your-application-name.herokuapp.com/webhooks/your-webhook-token
```

![image](https://cloud.githubusercontent.com/assets/536118/13662694/dc6ad3e6-e6df-11e5-8fed-905f9fc35ab4.png)

### Set esa webhook

```
heroku run console -a your-application-name
Webhook.create(from: 'esa', to: 'slack').token # Your webhook token
```

```
https://your-application-name.herokuapp.com/webhooks/your-webhook-token
```

![image](https://cloud.githubusercontent.com/assets/536118/13838757/d9110bfa-ec59-11e5-8578-acac57619576.png)

## Mentions mapping file example

https://gist.githubusercontent.com/ppworks/49f6ce44efb09d5fc8e9/raw/c1465aab5d6604b98ba6ca4c31263a5b36f62378/mention_mappings.yml

```
-
  github: ppworks
  slack: koshikawa.naoto
  esa: koshikawa_naoto
```
