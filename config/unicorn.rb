worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
  

  if defined?(Split) && !Split.redis.nil?
    Split.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  if defined?(Split)
    require 'open-uri'
    uri = URI.parse(ENV["REDISCLOUD_URL"] || "redis://localhost:6379")
    redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    Split.redis = redis
    Rails.logger.info('Connected to Redis')
  end
end