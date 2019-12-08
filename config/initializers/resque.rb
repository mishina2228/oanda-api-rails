require 'resque'
require 'resque-scheduler'
require 'resque/scheduler/server'
require 'resque/failure/multiple'
require 'resque/failure/redis'

Resque.redis = 'localhost:6379'
Resque.redis.namespace = "resque:oanda_api_rails:#{Rails.env}"
Resque::Scheduler.dynamic = true

Resque::Failure::Multiple.configure do |multi|
  multi.classes = [Resque::Failure::Redis, Resque::Failure::EmailNotification]
end
