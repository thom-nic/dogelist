os = require "os"

module.exports =
  redis:
    host: process.env.REDIS_IP or "localhost"
    port: process.env.REDIS_PORT or 6379
  cache_ttl: 30 * 60
  http_client_timeout: 4
  http_max_sockets: 20

  layout_vars:
    site_title: "Dogelist"
    site_description: "Craigslist with Dogecoin prices"

  session_key: "much wow"
  debug: true
  listen_port: 8888
  listen_ip: "0.0.0.0"
  
  # change this to a public hostname on prod:
  http_url: "http://#{os.hostname()}:8888"
