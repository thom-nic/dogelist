define ["marionette"], (Marionette) ->
  
  ###
  # get rid of that annoying wrapping div
  # this assumes 1 child element.  
  # See: http://stackoverflow.com/a/14679936/213983
  # Note: if onRender is overridden, make sure you call the `super` 
  # implementation like so: Elbow.ItemView.prototype.onRender.call(this)
  ###
  _new_render = ->
    if @$el.parent().length
      # console.log "re-render", @$el
      @$el = @$el.children()
      @$el.unwrap()
    else
      @$el = @$el.children()
    @setElement @$el

  ###
  # Instead of using `appendHtml` in a CollectionView, specify 
  # `appendSelector` which defines where in this view's DOM the 
  # item will be inserted.
  ###
  _appendHtml = (collectionView, itemView) ->
      if @appendSelector
        collectionView.$(@appendSelector).append itemView.el
      else
        collectionView.$el.append itemView.el

  Layout = Marionette.Layout.extend(onRender: _new_render)
  ItemView = Marionette.ItemView.extend(onRender: _new_render)
  CollectionView = Marionette.CollectionView.extend(
    onRender: _new_render
    appendHtml: _appendHtml
    appendSelector: null
  )
  CompositeView = Marionette.CompositeView.extend(
    onRender: _new_render
    appendHtml: _appendHtml
    appendSelector: null
  )
  
  ### 
  # Patch Backbone templates to use Mustache-style tokens
  # See: http://stackoverflow.com/a/15659028/213983
  ###
  Marionette.TemplateCache::compileTemplate = (rawTemplate) ->
    return _.template( rawTemplate, null, {
       interpolate: /\{!(.+?)\}/g
       escape: /\{(.+?)\}/g
       evaluate: /\{%(.+?)%\}/g
     })
  

  return {
    Layout: Layout
    ItemView: ItemView
    CollectionView: CollectionView
    CompositeView: CompositeView
  }
