redis = require 'redis'
http = require 'http'
https = require 'https'
url = require 'url'

###
# HTTP request wrapper that adds a cache layer in redis. 
# Note this uses a socket pool with HTTP 1.1 keepalive turned on
# by default to minimize request latency.
# FIXME Note this also assumes responses are always
###
class Request

  ###
  # Config options: 
  # `http_max_sockets` - number of concurrent requests
  # `timeout` - HTTP request timeout
  # ... additional options (See Cache)
  ###
  constructor: (config) ->
    @cache = new Cache(config)
    @request_timeout = config.http_client_timeout
    @http_agent = new http.Agent(maxSockets: config.http_max_sockets)
    @https_agent = new https.Agent(maxSockets: config.http_max_sockets)

  ###
  # For data that we don't expect to be updated frequently, our cache
  # will almost always be faster.  Check the cache first, and if it's 
  # reasonably fresh, return it.  If it's stale, then perform the HTTP 
  # request.
  ###
  get_cache_first: (_url, cb, max_age=60) ->
    @cache.get _url, (cache_data) =>
      now = new Date().getTime()
      not_stale = cache_data?.timestamp + max_age*1000 > now
      if cache_data?.data && not_stale
        console.log "Cache hit ", _url
        return cb cache_data

      # else cached data was stale, perform HTTP request
      console.log "HTTP client request to ", _url
      request_opts = url.parse(_url, false)
      if request_opts.protocol is 'http:'
        _http = http
        request_opts.agent = @http_agent
      else # https
        _http = https
        request_opts.agent = @https_agent

      #console.log('HTTP request!', request_opts)
      _http.get(
        request_opts,
        (resp) =>
          data = ""
          resp.on 'data', (chunk) ->
            data += chunk
          .on 'end', () =>
            data = JSON.parse data
            @cache.set _url, data
            cb data: data, timestamp : new Date().getTime()

      ).on 'error', (e) ->
        console.warn "HTTP client error", url, e
        cb cache_data  # best we can do, might be null
      .setTimeout @request_timeout
  
  # TODO get_http_first - always perform HTTP request & fall back to 
  # cache only if it fails
  

###
# Cache implementation (wraps redis get and set operations)
# Note we expire data only to keep entries which will never be
# re-used from taking up space forever.  In general stale data 
# is always preferable to no data, so long as the age is passed
# downstream, the client can make an informed decision based 
# on the age of the data.
###
class Cache

  constructor: (config) ->
    @cache = redis.createClient(
      config.redis.port,
      config.redis.host,
      auth_pass: config.redis.pass )
    @cache_ttl = config.cache_ttl # in seconds

    @cache.on 'error', (err) ->
      console.warn 'Redis error: ', err

  get: (url, cb) ->
    @cache.get url, (err,data) ->
      if err
        #console.warn "Redis error result", err
        return cb null

      cb JSON.parse data

  set: (url, data, cb) ->
    console.log "Updating cache for #{url}"
    @cache.setex url, @cache_ttl, JSON.stringify({
      timestamp: new Date().getTime()
      data: data
    }), cb

module.exports =
  Cache : Cache
  Request : Request
