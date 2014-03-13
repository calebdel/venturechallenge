redis_url = ENV["REDISCLOUD_URL"] || "redis://127.0.0.1:6379/0/venturechallenge"
Venturechallenge::Application.config.cache_store = :redis_store, redis_url
Venturechallenge::Application.config.session_store :redis_store, redis_server: redis_url