var require = {

  paths: {
    jquery: 'lib/jquery',
    bootstrap: 'lib/bootstrap',
    underscore: 'lib/underscore',
    json2: 'lib/json2',
    backbone: 'lib/backbone',
    backbone_associations: 'lib/backbone-associations',
    marionette: 'lib/backbone.marionette',
    moment: 'lib/moment.min',
  },

  shim : {
    jquery : {
      exports : 'jQuery'
    },

    bootstrap: ["jquery"],

    underscore : {
      exports : '_'
    },

    backbone : {
      deps : ['jquery', 'underscore'],
      exports : 'Backbone'
    },

    backbone_associations : {
      deps : ['backbone'],
      exports : 'Backbone'
    },

    marionette : {
      deps : ['jquery', 'underscore', 'backbone'],
      exports : 'Marionette'
    }
  },

  baseUrl : '/static/js'
}
