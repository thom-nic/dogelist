request = require './request-cache'

COINBASE_EXCHANGE_URL = 'https://coinbase.com/api/v1/currencies/exchange_rates'

class Coin

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
  usd_to_btc: (cb) ->

    @request.get_cache_first COINBASE_EXCHANGE_URL, (data) ->
      return cb() unless data # might be null, let the caller handle it
      cb
        timestamp: data.timestamp,
        rate: Number(data.data.usd_to_btc)

module.exports = Coin
