Venturechallenge::Application.config.session_store :redis_store, :servers => APP_CONFIG['REDISCLOUD_URL'], key: '_venturechallenge_session'

