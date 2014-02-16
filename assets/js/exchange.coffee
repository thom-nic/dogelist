define [
  "jquery",
  "backbone",
  "elbow"],
  ($, Backbone, Elbow) ->

    Rate = Backbone.Model.extend(
        defaults:
          rate : 1.0
          from_currency : "usd"
          to_currency : 'btc'
          timestamp : new Date()

        urlRoot: 'exchange'
        idAttribute: 'from_currency'

        url : () ->
          "#{@urlRoot}/#{@get('from_currency')}/#{@get('to_currency')}"
    )

    ExchangeView = Elbow.ItemView.extend(
      template: '#exchangeTmpl'
      tagName: 'ul'

      initialize: (opts) ->
        unless opts?.model
          @model = new Rate()
          @model.on 'change', @render
          @model.fetch()
        console.log "init", @$el

      onRender: () ->
        Elbow.ItemView::onRender.call this
        #console.log 'render!', @, @$el, @$el.parent()
    )

    return {
      Rate: Rate
      ExchangeView: ExchangeView
    }
