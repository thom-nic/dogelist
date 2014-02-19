# Dogelist

Craigslist in dogecoin

Basically this runs a craigslist search and returns prices of for-sale items 
in dogecoin (actually bitcoin right now, I can't find a direct USD to DOGE
conversion.)

## Motivation

Attempt to make a web app that's highly tolerant to network failures through
a combination of agressive caching and clever UI mechanisms.  Also an 
exercise for me to play with Backbone and CSS3 animations.

Caching happens at the app server level in case a dependent service is 
unreachable (Coinbase or Yahoo QL.)  Caching is also done at the client 
level via localstorage.

UI should be as responsive as possible, e.g. pull from localstorage first
and then replace the results as the HTTP response comes in.  Also the 
UI should clearly indicate the freshness of the data.  E.g. slowly
fade the dogecoin price from neutral to yellow/ red if the latest exchange
rate is not available.


## Requirements

* Node.js v0.10.x
* Redis v2.any
* Internets

## Run stuff

`npm start`

## Test stuff

`npm test`


