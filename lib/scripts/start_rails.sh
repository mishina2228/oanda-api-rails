#!/usr/bin/env bash
cd /home/pi/git-repos/oanda-api-rails
bundle exec rake assets:precompile RAILS_ENV=production
bundle exec rails s -b 192.168.1.12 -e production -d
