CDNJS_PATHS =
  jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min'
  bootstrap: '//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.0/js/bootstrap.min'
  underscore: '//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min'
  json2: '//cdnjs.cloudflare.com/ajax/libs/json2/20121008/json2'
  backbone: '//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.0/backbone-min'
  marionette: '//cdnjs.cloudflare.com/ajax/libs/backbone.marionette/1.1.0-bundled/backbone.marionette.min'
  moment: '//cdnjs.cloudflare.com/ajax/libs/moment.js/2.4.0/moment.min'
  mustache: '//cdnjs.cloudflare.com/ajax/libs/mustache.js/0.7.2/mustache.min'
  text: '//cdnjs.cloudflare.com/ajax/libs/require-text/2.0.10/text.min'
  select2: '//cdnjs.cloudflare.com/ajax/libs/select2/3.4.5/select2.min'
  backbone_cache: '//cdnjs.cloudflare.com/ajax/libs/backbone.fetch-cache/1.1.2/backbone.fetch-cache.min'

LOCAL_BASEDIR = '/static/js/lib/'

LOCAL_PATHS =
  jquery: "#{LOCAL_BASEDIR}jquery"
  bootstrap: "#{LOCAL_BASEDIR}bootstrap"
  underscore: "#{LOCAL_BASEDIR}underscore"
  json2: "#{LOCAL_BASEDIR}json2"
  backbone: "#{LOCAL_BASEDIR}backbone"
  backbone_associations: "#{LOCAL_BASEDIR}backbone-associations"
  backbone_cache: "#{LOCAL_BASEDIR}backbone.fetch-cache"
  marionette: "#{LOCAL_BASEDIR}backbone.marionette"
  moment: "#{LOCAL_BASEDIR}moment.min"
  text: "#{LOCAL_BASEDIR}require_text"
  select2: "#{LOCAL_BASEDIR}select2/select2"

  regions: '/static/js/regions'
  categories: '/static/js/categories'

@require =
  paths: LOCAL_PATHS #if @USE_CDN then CDNJS_PATHS else LOCAL_PATHS

  shim:
    jquery:
      exports: "jQuery"

    bootstrap: ["jquery"]
    underscore:
      exports: "_"

    backbone:
      deps: ["jquery", "underscore"]
      exports: "Backbone"

    backbone_associations:
      deps: ["backbone"]
      exports: "Backbone"

    marionette:
      deps: ["jquery", "underscore", "backbone"]
      exports: "Marionette"

    select2:
      deps: ["jquery"]

  baseUrl: '/js' # for app scripts only, not third-party rquirements
