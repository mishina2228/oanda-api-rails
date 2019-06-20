cd /home/pi/git-repos/oanda-api-rails
QUEUE=normal bundle exec rake environment resque:work &
DYNAMIC_SCHEDULE=true PIDFILE=./tmp/pids/resque-scheduler.pid BACKGROUND=yes bundle exec rake environment resque:scheduler
