express = require "express"
app = express()
server = require("http").createServer(app)
path = require "path"
assets = require 'connect-assets'
RedisStore = require("connect-redis")(express)

config = require "./config"
routes = require './lib/routes'
Coin = require './lib/coin'
Craigslist = require './lib/craigslist'

basedir = process.cwd()

app.configure ->
  app.set "views", path.join(basedir, "views")
  app.set "view engine", "jade"
  app.use express.logger() unless process.env.COVERAGE
  app.use express.compress()
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use assets( src:'assets' )
  app.use express.session({
    store:  new RedisStore(config.redis),
    secret: config.session_key,
    cookie: {
      secure: false,
      maxAge: 86400000
    }
  })
  app.use '/static', express.static(path.join(basedir, "static"))
  app.use app.router

  app.use (err, req, res, next) ->
    console.warn err

coin = new Coin config
craigslist = new Craigslist config

routes.init app, config, coin, craigslist

quit = (sig) ->
  if typeof sig is "string"
    console.log "%s: Received %s - terminating Node server ...", Date(), sig
    process.exit 1
  console.log "%s: Node server stopped.", Date()

# Process on exit and signals.
process.on "exit", quit

"HUP,INT,QUIT".split(",").forEach (sig, i) ->
  process.on "SIG#{sig}", ->
    quit "SIG#{sig}"

# Run server
server.listen config.listen_port, config.listen_ip, ->
  console.log "Node (version: %s) %s started on %s:%d ...",
    process.version, process.argv[1], config.listen_ip, config.listen_port


module.exports = app
