# Dogelist

Craigslist in dogecoin/ Bitcoin

[![Build Status](https://img.shields.io/travis/tomstrummer/dogelist.svg)](https://travis-ci.org/tomstrummer/dogelist) [![Dependency Status](https://img.shields.io/gemnasium/tomstrummer/dogelist.svg)](https://gemnasium.com/tomstrummer/dogelist) 

Basically this runs a craigslist search and returns prices of for-sale items 
in dogecoin (actually bitcoin right now, I can't find a direct USD to DOGE
conversion.)

## Motivation

Attempt to make a web app that's highly tolerant to network failures through
a combination of agressive caching and clever UI feedback.  Also an 
exercise for me to play with Backbone and CSS3 animations.

Caching happens at the app server level in case a dependent service is 
unreachable (Coinbase or Yahoo QL.)  Caching is also done at the client 
level via localstorage.

UI should be as responsive as possible, e.g. pull from localstorage first
and then replace the results as the HTTP response comes in.  Also the 
UI should clearly indicate the freshness of the data.  E.g. slowly
fade the dogecoin price from neutral to yellow/ red if the latest exchange
rate is not available.


## Requirements & Setup

* Node.js v0.10.x
* Redis v2.any
* Internets

Run `npm install && npm run-script setup` to install node modules and bower modules.

## Much run

`npm start`

## Much test

`npm test`


