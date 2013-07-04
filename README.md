# Jenkins Dashboard

A nice looking dashboard for your Jenkins projects. It pulls in each of your projects and shows the current build state along with the state of the previous (up to) 5 builds. It's meant to be shown on an always-visible screen so it'll keep up to date with little Jenkins' hard work. Looks pretty reasonable on smaller browsers, too.


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


##License
```
Copyright 2013 Jack Weeden

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```