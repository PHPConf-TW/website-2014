# PHPConf Website

[![Build Status](https://travis-ci.org/PHPConf-TW/website-2014.png)](http://travis-ci.org/PHPConf-TW/website-2014) 

Souce Code for [PHPConf Taiwan 2014](http://phpconf.tw/2014/)

## Installation

Please install node.js first (>0.10) and [bower](http://bower.io/) package manager

```
$ npm install -g bower
$ npm install && bower install
```

Start App

```
$ npm start
```

Excuting above command will output the following message.

```
> phpconf-tw-2014@0.1.0 start /xxxxx/website-2014
> gulp

[13:50:30] Requiring external module coffee-script/register
[13:50:31] Using gulpfile /xxxxx/website-2014/gulpfile.coffee
[13:50:31] Starting 'default'...
[13:50:31] Starting 'connect:app'...
[13:50:31] Finished 'connect:app' after 13 ms
[13:50:31] Finished 'default' after 14 ms
[BS] Local: >>> http://localhost:3000
[BS] External: >>> http://xxx.xxx.xxx.xxx:3000
[BS] Serving files from: app
```

Open browser like chrome or firefox and enter http://localhost:3000 URL.

## Release

Execute the following command will generate dist folder.

$ npm run release

## Test

To test release process by following command.

$ npm test
