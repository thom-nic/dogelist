define [
  "jquery",
  "backbone",
  "craigslist",
  "exchange" ],
($, Backbone, craigslist, exchange) ->

  router = Backbone.Router.extend(
    routes:
      "" : "home",
      "search/:region/:category" : "search"

    home: () ->
      console.log "Home"

    search: (category, query) ->
      console.log "Search #{category} #{query}"
  )

  return router
