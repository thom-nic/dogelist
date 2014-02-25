define [
  "jquery",
  "backbone",
  "elbow",
  "moment",
  "bootstrap",
  "backbone_cache" ],
  ($, Backbone, Elbow, moment) ->

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
          @refresh()
        console.log "init", @$el

      refresh: ->
        @model.fetch prefill: true

      rateChange: (model) ->
        console.log "Rate change event", model
        @trigger "rate:change", model

      onRender: ->
        Elbow.ItemView::onRender.call @
        #console.log 'render!', @, @$el, @$el.parent()

      onDomRefresh: ->
        @$el.find('[data-toggle="tooltip"]').tooltip()
                
      templateHelpers:
        last_refresh_ts: () ->
          moment(@timestamp).calendar()
    )

    return {
      Rate: Rate
      ExchangeView: ExchangeView
    }
