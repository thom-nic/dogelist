define [ "jquery",
         "backbone",
         "router",
         "exchange" ],
         ($, Backbone, router, exchange) ->

  App= new Backbone.Marionette.Application()
  App.addRegions
    currentPriceRegion: "#currentPrice"
    listRegion: "#list"

  App.addInitializer (opts) ->
    list = new list.ResultList()
    App.listRegion.show new list.ListView(collection: list)
    @controller = new search.SearchController(
      resultList: list
    )

  App.on "initialize:after", ->
    console.log "Started app", this

  
  App.router = new router.Router()
  Backbone.history.start()
    
  $(document).ready ->
    App.start()
    $(document).ajaxStart ->
      $("i.fa-spin").show()

    $(document).ajaxStop ->
      $("i.fa-spin").fadeOut()


  return app: App

