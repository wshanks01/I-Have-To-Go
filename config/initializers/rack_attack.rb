# Only allow dev site
# Rack::Attack.safelist('allow-devsite') do |req|
#   'localhost:3001' == req.ip
# end

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

# Allow an IP address to make 5 requests every 1 seconds
Rack::Attack.throttle('req/ip', :limit => 5, :period => 1.second) do |req|
  req.ip
end

# Lockout IP addresses that are hammering login page.
# After 20 requests in 1 minute, block all requests from that IP for 1 hour.
Rack::Attack.blocklist('allow2ban login scrapers') do |req|
  # `filter` returns false value if request is to your login page (but still
  # increments the count) so request below the limit are not blocked until
  # they hit the limit.  At that point, filter will return true and block.
  Rack::Attack::Allow2Ban.filter(req.ip, :maxretry => 20, :findtime => 1.minute, :bantime => 1.hour) do
    # The count for the IP is incremented if the return value is truthy.
    req.path == '/login' and req.post?
  end
end

# Send the following response to throttled clients
Rack::Attack.throttled_response = ->(env) {
  retry_after = (env['rack.attack.match_data'] || {})[:period]
  [
    429,
    {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
    [{error: "Throttle limit reached. Retry later."}.to_json]
  ]
}