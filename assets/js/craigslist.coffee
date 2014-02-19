define [
  "jquery",
  "text!regions.json",
  "text!categories.json",
  "backbone",
  "elbow",
  'form' ],
  ($, regions, categories, Backbone, Elbow) ->

    Post = Backbone.Model.extend(
        defaults:
          link : null
          title : ""
          timestamp : new Date()
          price : 0
          calc_price : NaN
          description : ''

        urlRoot: 'craigslist/item'
    )

    Search = Backbone.Collection.extend(
        model: Post

        initialize: (opts) ->
          console.log "Search opts", opts
          @params = opts.params

        # search parameters, filled during initialize
        params:
          query: null
          category: null
          region: null

        urlRoot: '/search'
        url: () ->
          "#{@urlRoot}/#{encodeURIComponent @params.region}\
           /#{encodeURIComponent @params.category}\
           ?q=#{encodeURIComponent @params.query}"
    )

    SearchFormView = Elbow.ItemView.extend(
      template: '#searchTmpl'

      serializeData: () ->
        categories: JSON.parse categories
        regions: JSON.parse regions

      ui:
        searchForm: '#searchForm'

      events:
        'submit @ui.searchForm': 'doSearch'
        'click #searchBtn': 'doSearch'

      doSearch: (e) ->
        e.preventDefault()
        params = @ui.searchForm.form2obj()
        console.log "Form params",e, params

        new Search(
          params: params
        ).fetch(
          success: (collection, response, options) =>
            console.debug "Search success", collection
            @trigger "search:results", collection

          error: (collection, response, options) =>
            console.debug "Search error", collection, response
            @trigger "search:error", collection
        )
    )

    ResultItemView = Elbow.ItemView.extend(
      template: "#searchResultItemTmpl"
    )

    NoResultsView = Elbow.ItemView.extend(
      template: "#noSearchResultsTmpl"
    )

    SearchResultsView = Elbow.CollectionView.extend(
      template: "#searchResultsTmpl"
#      appendSelector: '.searchResults'
      itemView: ResultItemView
      emptyView: NoResultsView
      currentRate: null

      updateRate: (model) ->
        @currentRate = model.get 'rate'
        return unless @collection?
        @collection.each (item,i) =>
          item.set "calc_price", item.get('price')* @currentRate
          #console.log "updated rate", item, @currentRate

      onRender: () ->
        console.log "render collection", @
    )

    return {
      Post : Post
      Search : Search
      SearchFormView : SearchFormView
      SearchResultsView : SearchResultsView
    }
