define [
  "jquery",
  "backbone",
  "elbow",
  "backbone_cache" ],
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

      modelEvents:
        "change": "render rateChange"

      initialize: (opts) ->
        unless opts?.model
          @model = new Rate()
          @model.fetch prefill: true
        console.log "init", @$el

      # FIXME periodically update the rate from the server

      rateChange: (model) ->
        console.log "Rate change event", model
        @trigger "rate:change", model

      onRender: () ->
        Elbow.ItemView::onRender.call this
        #console.log 'render!', @, @$el, @$el.parent()
    )

    return {
      Rate: Rate
      ExchangeView: ExchangeView
    }
