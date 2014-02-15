


init = (app, config, coin, craigslist) ->

  app.get '/', (req, res) ->
    res.render 'index', config.layout_vars


  app.get '/exchange', (req, res) ->
    coin.usd_to_btc (rate) ->
      return res.json 503, {error: {message : "Exchange rate unavailable"} } unless rate

      res.json rate


  app.get '/search/:location/:category', (req, res) ->
    craigslist.search(
      req.params.location,
      req.params.category,
      req.query.q,
      (results) ->
        return res.json 503, {error: {message : "Craigslist unavailable"} } unless results
        res.json results
    )

module.exports =
  init : init
