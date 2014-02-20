define [
  "jquery",
  "backbone",
  "router",
  "exchange",
  "craigslist",
  "marionette",
  "bootstrap" ],
  ($, Backbone, Router, exchange, craigslist, bootstrap) ->

    App= new Backbone.Marionette.Application()
    App.addRegions
      exchangeRegion: "#exchangeRegion"
      searchFormRegion: '#searchFormRegion'
      searchResultsRegion: '#searchResultsRegion'

    App.addInitializer (opts) ->

      exchangeView = new exchange.ExchangeView()
      searchForm = new craigslist.SearchFormView()

      searchForm.on "search:results", (searchResults) ->
        console.log 'results', searchResults
        view = new craigslist.SearchResultsView(
          collection: searchResults )
        if exchangeView.model
          view.updateRate exchangeView.model
        exchangeView.on "rate:change", (newRate) ->
          console.log "New rate", newRate
          view.updateRate newRate
        App.searchResultsRegion.show view
        App.hideError()

      .on "search:error", () ->
         App.showError "Search error!  Please try again!"

      $('#errorMsg .close').on 'click', (e) ->
        App.hideError()

      App.exchangeRegion.show exchangeView
      App.searchFormRegion.show searchForm
      App.searchResultsRegion.show new craigslist.SearchResultsView()

    App.on "initialize:after", ->
      console.log "Started app", @

    
    App.router = new Router()
    Backbone.history.start()
      
    $(document).ready ->
      App.start()
      $(document).ajaxStart ->
        $("i.fa-spin").show()

      $(document).ajaxStop ->
        $("i.fa-spin").fadeOut()


    App.hideError = ->
      $('#errorMsg').removeClass 'in'

    App.showError = (msg) ->
      $('#errorMsg').addClass('in').find('.errorText').text(msg)

    return app: App

