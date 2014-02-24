app = require '../server'
request = require('supertest')(app)
config = require './config'
expect = require('chai').expect

suite 'routes', () ->
  suite 'exchange', () ->

    test 'btc/usd', (done) ->
      request
        .get "/exchange/btc/usd"
        .expect 200
        .expect 'Content-Type', /json/
        .end (err, res) ->
          expect(err).to.equal null
          expect(res.body).to.be.an 'object'
#          console.log res.body
          expect(res.body.timestamp).to.be.not.null
          expect(res.body.rate).to.be.a 'number'
          done()

  suite 'craigslist', () ->

    test "search", () ->
      request
        .get "/search/providence/bik?q=single%20speed"
        .expect 200
        .expect 'content-type', /json/
        .end (err, res) ->
          expect(err).to.equal null
          expect(res).to.be.an 'array'
          done()


  suite 'root', ->
    test '/', (done) ->
      request
        .get "/"
        .expect 200
        .expect 'content-type', /html/
        .end (err,res) ->
          done()
