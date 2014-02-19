jsdom = require 'jsdom'

###
# Quick and dirty script to parse listing categories out of cragislist.
# Save the output from stdout to /static/js/categories.json
###


getCategories = (cb) ->

  states = {}
  jsdom.env
    url: "http://providence.craigslist.org/sss"
    scripts: ["http://code.jquery.com/jquery.js"]
    done: (errors, window) ->
      $ = window.$
      options = $('#searchform option')

      categories = []
      options.each (i,opt) ->
        opt = $ opt
        text = opt.text().trim()
        #console.log text
        if opt.attr "data-acat"
          categories.push cat: opt.val(), title: text

      #console.log "Done!\n"
      cb categories

getCategories (categories) ->
  console.log JSON.stringify categories
