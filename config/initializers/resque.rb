require 'resque'
require 'resque-scheduler'
require 'resque/scheduler/server'

Resque.redis = 'localhost:6379'
Resque.redis.namespace = "resque:oanda_api_rails:#{Rails.env}"
Resque.logger = Logger.new('log/resque.log', 5, 10.megabytes)
Resque.logger.level = Logger::INFO
# The schedule doesn't need to be stored in a YAML, it just needs to
# be a hash.  YAML is usually the easiest.
# https://github.com/resque/resque-scheduler/issues/541#issuecomment-218611385
Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
