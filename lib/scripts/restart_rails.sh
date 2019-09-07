#!/usr/bin/env bash

cd /home/pi/git-repos/oanda-api-rails

sh ./lib/scripts/finish_rails.sh
echo 'stopped rails.'
echo 'sleep 5 seconds ...'
sleep 5s

sh ./lib/scripts/start_rails.sh
