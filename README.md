# unblibraries/hubot-slack
Docker container : leverages phusion/baseimage to deploy our hubot for slack.

## Usage
```
docker run --rm \
    --name hubot-slack \
    -e HUBOT_GOOGLE_API_KEY= \
    -e HUBOT_SLACK_TOKEN= \
    -e REDIS_URL=redis://192.168.2.202:6379/hubotslack \
    unblibraries/hubot-slack
```

## License
- unblibraries/hubot-slack is licensed under the MIT License:
  - http://opensource.org/licenses/mit-license.html
- Attribution is not required, but much appreciated:
  - `Hubot for Slack Docker Container by UNB Libraries`

## Credit
- Original work for this container was based on that of [Nathaniel Hoag](http://nathanielhoag.com/blog/2014/12/07/a-dockerized-slack-integrated-hubot/).
