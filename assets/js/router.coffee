define [ "jquery",
         "backbone",
         "search",
         "list",
         "exchange" ],
         ($, Backbone, search, list, exchange) ->

  router = Backbone.Router.extend({

    routes:
      "" : "home",
      "search/:category/:query" : "search"

    home: () ->
      console.log "Home"

    search: (category, query) ->
      console.log "Search #{category} #{query}"

  })

  return router.Router
