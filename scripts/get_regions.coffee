jsdom = require 'jsdom'

###
# Quick and dirty script to parse listing regions for cragislist.
# Save the output from stdout to /static/js/regions.json
###


getRegions = (cb) ->

  states = {}
  jsdom.env
    url: "http://www.craigslist.org/about/sites"
    scripts: ["http://code.jquery.com/jquery.js"]
    done: (errors, window) ->
      $ = window.$
      section = $('a[name="US"]').parent().next()

      stateHeaders = section.find('h4')
      regions = section.find('ul')

      stateHeaders.each (i,stateHeader) ->
        state = $(stateHeader).text()
        #console.log state
        regionList = $(regions[i])
        states[state] = regionList.find('a').map ->
          regionLink = $(@)
          #console.log "url", regionLink.attr('href')
          regionMatch = regionLink.attr('href').match /http:\/\/([^\.]+)\.craigslist\.org/
          region = regionMatch[1]
          {name: regionLink.text(), region: region}
        .get()
        #console.log states[state]

      #console.log "Done!\n"
      cb states

getRegions (states) ->
  console.log JSON.stringify states
