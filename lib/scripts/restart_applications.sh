#!/usr/bin/env bash
cd `dirname $0`/../..

sh ./lib/scripts/finish_rails.sh
sh ./lib/scripts/finish_resque.sh
echo 'stopped rails and resque.'
echo 'sleep 5 seconds ...'
sleep 5s
sh ./lib/scripts/start_resque.sh
sh ./lib/scripts/start_rails.sh
