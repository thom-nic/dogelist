env = process.env

module.exports =
  redis_host: env.REDIS_IP or "localhost"
  redis_port: env.REDIS_PORT or 6379
  cache_ttl: 30 * 60
  http_client_timeout: 4
  http_max_sockets: 20

  layout_vars:
    site_title: "Dogelist"
    site_description: "Craigslist with Dogecoin prices"

  session_key: "much wow"
  debug : ! env.OPENSHIFT_GEAR_DNS
  listen_port : parseInt(env.OPENSHIFT_INTERNAL_PORT) or 8888
  listen_ip : (env.OPENSHIFT_INTERNAL_IP or "127.0.0.1")

