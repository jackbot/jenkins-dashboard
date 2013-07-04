# Jenkins Dashboard

A nice looking dashboard for your Jenkins projects. It pulls in each of your projects and shows the current build state along with the state of the previous (up to) 5 builds. It's meant to be shown on an always-visible screen so it'll refresh itself every 10 seconds. Looks pretty reasonable on smaller browsers, too.


## Installation
```shell
bundle install
mv .env.example .env
vim .env
```

## Configuration
The only configuration that needs doing is in the `.env` file. Set a username and password for the dashboard if you like and plug in your Jenkins user/password and URL. It's recommended to add a new user to your Jenkins install which has just read-only access.


## Running
```shell
rackup
```

Alternatively, point your nginx config to the `public` directory and you're good to go!

## Screenshot
![Screenshot](http://jackweeden.s3.amazonaws.com/github/jenkins-dash.png)