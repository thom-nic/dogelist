request = require './request-cache'

COINBASE_EXCHANGE_URL = 'https://coinbase.com/api/v1/currencies/exchange_rates'
COINBASE_REFRESH_LIMIT = 60 # coinbase doc states it does not refresh > 60 seconds

###
# https://coinbase.com/api/doc/1.0/currencies/exchange_rates.html
###
class Coin

  ###
  # config.auto_refresh_rates = [
  #   ['usd','btc'],
  #   ...
  # ]
  # config.auto_refresh_interval = 60
  ###
  constructor: (config) ->
    @request = new request.Request config

    interval = config.exchange_auto_refresh_interval
    @_start_auto_refresh interval if interval


  ###
  # 60 second max age is good here, Coinbase exchange doesn't 
  # update any more freqently than that.
  # We could optimize this further by having a periodic job that performs 
  # 1 query/min, which would mean all user requests hit the cache.
  # Currently 1 user request every 60 seconds will have to wait for 
  # coinbase to return the result.
  ###
  exchange_rate: (from_currency, to_currency, cb) ->

    @request.get_cache_first COINBASE_EXCHANGE_URL, (data) ->
      return cb() unless data # might be null, let the caller handle it
      cb
        from: from_currency
        to: to_currency
        timestamp: data.timestamp
        rate: Number(data.data["#{from_currency}_to_#{to_currency}"])
    , max_age=COINBASE_REFRESH_LIMIT

  
  ###
  # FIXME this really ought to be run as a separate job where it can be
  # properly scheduled and processed among worker nodes instead of tied 
  # to this node.  
  ###
  _start_auto_refresh: (interval) ->
    console.log "Starting auto refresh every #{interval}s"

    @_interval = setInterval =>
      @exchange_rate 'btc', 'usd', (update) =>
        return unless update?
        console.log "Updated rate BTC to USD = #{update.rate}"
    , interval * 1000


  stop_auto_refresh: ->
    return unless @_interval
    clearInterval @_interval
    console.log "Cleared auto-refresh"


module.exports = Coin
