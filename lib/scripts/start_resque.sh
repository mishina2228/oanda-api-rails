cd /home/pi/git-repos/oanda-api-rails
bundle exec rake environment resque:work QUEUE=normal &
bundle exec rake environment resque:scheduler &
