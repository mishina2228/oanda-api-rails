#!/usr/bin/env bash

cd `dirname $0`/../..

sh ./lib/scripts/finish_rails.sh
echo 'stopped rails.'
echo 'sleep 5 seconds ...'
sleep 5s

sh ./lib/scripts/start_rails.sh
