#!/usr/bin/env bash
cd `dirname $0`/../..

echo 'starting resque.'

QUEUE=normal RAILS_ENV=production bundle exec rake environment resque:work &
DYNAMIC_SCHEDULE=true PIDFILE=./tmp/pids/resque-scheduler.pid BACKGROUND=yes LOGFILE=./log/resque-scheduler.log RAILS_ENV=production bundle exec rake environment resque:scheduler

echo 'started resque.'
