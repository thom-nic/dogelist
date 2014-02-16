define [
  "jquery",
  "backbone",
  "router",
  "exchange",
  "marionette" ],
  ($, Backbone, Router, exchange) ->

    App= new Backbone.Marionette.Application()
    App.addRegions
      exchangeRegion: "#exchangeRegion"

    App.addInitializer (opts) ->
      App.exchangeRegion.show new exchange.ExchangeView()

    App.on "initialize:after", ->
      console.log "Started app", this

    
    App.router = new Router()
    Backbone.history.start()
      
    $(document).ready ->
      App.start()
      $(document).ajaxStart ->
        $("i.fa-spin").show()

      $(document).ajaxStop ->
        $("i.fa-spin").fadeOut()


    return app: App

