#!/usr/bin/env bash
cd /home/pi/git-repos/oanda-api-rails
bundle exec rake assets:precompile RAILS_ENV=production
bundle exec rails s -b `ip -4 a show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}'` -e production -d
