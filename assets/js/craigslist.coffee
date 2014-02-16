define [
  "jquery",
  "backbone" ],
  ($, Backbone) ->

    Post = Backbone.Model.extend(
        defaults:
          link : null
          title : ""
          timestamp : new Date()
          price : 0
          description : ''

        urlRoot: 'craigslist/item'
    )

    SearchResult = Backbone.Collection.extend(
        model: Post
        url: 'craigslist/search'
    )

    return {
      Post : Post
      SearchResult : SearchResult
    }
