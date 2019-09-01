#!/usr/bin/env bash
cd /home/pi/git-repos/oanda-api-rails
sh ./lib/scripts/finish_rails.sh
sh ./lib/scripts/finish_resque.sh
echo 'stopped rails and resque.'
echo 'sleep 5 seconds ...'
sleep 5s
sh ./lib/scripts/start_resque.sh
sh ./lib/scripts/start_rails.sh

