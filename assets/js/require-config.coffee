CDN_BASE = '//cdnjs.cloudflare.com/ajax/libs/'

CDNJS_PATHS =
  jquery: "#{CDN_BASE}jquery/2.0.3/jquery.min"
  bootstrap: "#{CDN_BASE}twitter-bootstrap/3.1.0/js/bootstrap.min"
  underscore: "#{CDN_BASE}underscore.js/1.5.2/underscore-min"
  json2: "#{CDN_BASE}json2/20121008/json2"
  backbone: "#{CDN_BASE}backbone.js/1.1.0/backbone-min"
  marionette: "#{CDN_BASE}backbone.marionette/1.1.0-bundled/backbone.marionette.min"
  moment: "#{CDN_BASE}moment.js/2.4.0/moment.min"
  text: "#{CDN_BASE}require-text/2.0.10/text.min"
  select2: "#{CDN_BASE}select2/3.4.5/select2.min"
  backbone_cache: "#{CDN_BASE}backbone.fetch-cache/1.1.2/backbone.fetch-cache.min"

LOCAL_BASEDIR = '/static/lib/'

LOCAL_PATHS =
  jquery: "#{LOCAL_BASEDIR}jquery/jquery"
  bootstrap: "#{LOCAL_BASEDIR}bootstrap/dist/js/bootstrap"
  underscore: "#{LOCAL_BASEDIR}underscore/underscore"
  json2: "#{LOCAL_BASEDIR}json2/json2"
  backbone: "#{LOCAL_BASEDIR}backbone/backbone"
  backbone_cache: "#{LOCAL_BASEDIR}backbone-fetch-cache/backbone.fetch-cache"
  marionette: "#{LOCAL_BASEDIR}/marionette/lib/backbone.marionette"
  moment: "#{LOCAL_BASEDIR}moment/moment"
  text: "#{LOCAL_BASEDIR}requirejs-text/text"
  select2: "#{LOCAL_BASEDIR}select2/select2"


use_local = (document?.documentElement.getAttribute('data-debug') == 'true')
paths = if use_local then LOCAL_PATHS else CDNJS_PATHS

paths.regions= '/static/json/regions'
paths.categories= '/static/json/categories'

@require =
  paths: paths

  shim:
    jquery:
      exports: "jQuery"

    bootstrap: ["jquery"]
    underscore:
      exports: "_"

    backbone:
      deps: ["jquery", "underscore"]
      exports: "Backbone"

    marionette:
      deps: ["jquery", "underscore", "backbone"]
      exports: "Marionette"

    select2:
      deps: ["jquery"]

  baseUrl: '/js' # for app scripts only, not third-party rquirements
