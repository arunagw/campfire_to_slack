campfire_to_slack
=================

Live Post from Campfire to Slack

Heroku
==============

Just push this repo on heroku and you will be able to live stream from an
Campfire room to Slack room.


Configuration
================

Setup a incoming webhook from Slack Account ( https://my.slack.com/services/new/incoming-webhook )

Setup Heroku environment variable to make script work.

    heroku config:set CAMPFIRE_ROOM=myroom CAMPFIRE_SUBDOMAIN=mycompany CAMPFIRE_TOKEN=token-i-have SLACK_WEBHOOK_URL=webhook-from-slack

Scale heroku process by running
    heroku ps:scale post_slack=1
