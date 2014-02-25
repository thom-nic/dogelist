


init = (app, config, coin, craigslist) ->

  app.get '/', (req, res) ->
    res.render 'index', config.layout_vars


  app.get '/exchange/:from_currency/:to_currency', (req, res) ->
    coin.exchange_rate(
      req.params.from_currency,
      req.params.to_currency,
      (rate) ->
        return res.json 503, {error: {message : "Exchange rate unavailable"} } unless rate

        res.json rate
      , max_age=900
    )

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
