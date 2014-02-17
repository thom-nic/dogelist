_ = require 'underscore'
request = require './request-cache'

class Craigslist

  constructor: (config) ->
    @request = new request.Request config

  ###
  # 60 second max age is good here, Coinbase exchange doesn't 
  # update any more freqently than that.
  # We could optimize this further by having a periodic job that performs 
  # 1 query/min, which would mean all user requests hit the cache.
  # Currently 1 user request every 60 seconds will have to wait for 
  # coinbase to return the result.
  ###
  search: (location, type, q, cb) ->
    _url = _fmt_craigslist_url location, type, q

    @request.get_cache_first _url, (data) ->
      #console.log data
      cb data?.data?.query?.results?.RDF?.item?.map _format


_fmt_craigslist_url = (loc,type,q) ->
  "http://query.yahooapis.com/v1/public/yql?\
   q=select%20*%20from%0Acraigslist.search%20where%20\
   location%3D%22#{escape(loc)}%22%20and%20\
   type%3D%22#{escape(type)}%22%20and%20\
   query%3D%22#{escape(q)}%22\
   &format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"

_format = (i) ->
  title = i.title[0]
  console.log title
  [title, price] = title.split('&#x0024;') # escaped '$'

  return {
    link : i.link
    title: _.unescape title
    price: price
    description: _.unescape i.description
    posted: i.date
  }

module.exports = Craigslist
