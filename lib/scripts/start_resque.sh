cd /home/pi/git-repos/oanda-api-rails
QUEUE=normal bundle exec rake environment resque:work &
DYNAMIC_SCHEDULE=true bundle exec rake environment resque:scheduler &>> ./log/resque-scheduler.log &
