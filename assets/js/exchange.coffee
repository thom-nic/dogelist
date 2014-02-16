define [
  "jquery",
  "backbone",
  "elbow"],
  ($, Backbone, Elbow) ->

    Rate = Backbone.Model.extend(
        defaults:
          rate : 1.0
          to_currency : "USD"
          timestamp : new Date()

        urlRoot: 'exchange'
    )

    ExchangeView = Elbow.Layout.extend(

    )

    return {
      Rate: Rate
      ExchangeView: ExchangeView
    }
