redis_url = ENV["REDISCLOUD_URL"] 
Venturechallenge::Application.config.cache_store = :redis_store, redis_url
Venturechallenge::Application.config.session_store :redis_store, redis_server: redis_url 