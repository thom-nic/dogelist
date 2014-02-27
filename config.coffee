env = process.env

debug = ! env.OPENSHIFT_GEAR_DNS

module.exports =
  redis:
    hosthost: env.OPENSHIFT_REDIS_HOST or "localhost"
    port: env.OPENSHIFT_REDIS_PORT or 6379
    pass: env.REDIS_PASSWORD or null
  cache_ttl: 30 * 60
  http_client_timeout: 4
  http_max_sockets: 20

  layout_vars:
    debug: debug
    local_assets: debug
    static_asset_dir: '/static/lib/'
    site_title: "Dogelist"
    site_description: "Craigslist with Dogecoin prices"

  session_key: "much wow"
  debug : debug
  listen_port : parseInt(env.OPENSHIFT_NODEJS_PORT) or 8888
  listen_ip : (env.OPENSHIFT_NODEJS_IP or "127.0.0.1")

  exchange_auto_refresh_interval: 61
