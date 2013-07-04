# Jenkins Dashboard

A nice looking dashboard for your Jenkins projects.


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