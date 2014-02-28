phantom = require 'phantom'
expect = require('chai').expect
config = require '../config'

return if config.skip_functional_tests

suite 'phantom', ->

  ph = null

  before (done) ->
    phantom.create (_ph) ->
      ph = _ph
      done()

  after (done) ->
    ph.exit()
    done()

  test 'index', (done) ->

    ph.createPage (page) ->
      page.open config.http_url, (status) ->
        expect(status).to.equal 'success'
        page.evaluate (-> document.title), (title) ->
          expect(title).to.equal 'Dogelist'
          done()
