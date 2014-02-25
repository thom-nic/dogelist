define [
  "jquery",
  "backbone",
  "router",
  "exchange",
  "craigslist",
  "marionette",
  "bootstrap" ],
  ($, Backbone, Router, exchange, craigslist, bootstrap) ->

    App = Backbone.Marionette.Application.extend(
      startExchangeRefresh: (view) ->
        @exchangeRefreshInterval = setInterval ->
          view.refresh()
        , 60000

      showError: (msg) ->
        $('#errorMsg').addClass('in').find('.errorText').text msg
      
      hideError: ->
        $('#errorMsg').removeClass 'in'
    )

    app= new App()
    app.addRegions
      exchangeRegion: "#exchangeRegion"
      searchFormRegion: '#searchFormRegion'
      searchResultsRegion: '#searchResultsRegion'

    app.addInitializer (opts) ->

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
        app.searchResultsRegion.show view
        app.hideError()

      .on "search:error", () ->
         app.showError "Search error!  Please try again!"

      $('#errorMsg .close').on 'click', (e) ->
        app.hideError()

      app.exchangeRegion.show exchangeView
      app.searchFormRegion.show searchForm
      app.searchResultsRegion.show new craigslist.SearchResultsView()

      app.startExchangeRefresh exchangeView

    app.on "initialize:after", ->
      console.log "Started app", @
    
    app.router = new Router()
    Backbone.history.start()
      
    $(document).ready ->
      app.start()
      $(document).ajaxStart ->
        $("i.fa-spin").show()

      $(document).ajaxStop ->
        $("i.fa-spin").fadeOut()


    return app: app

