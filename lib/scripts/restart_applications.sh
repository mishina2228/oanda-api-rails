cd /home/pi/git-repos/oanda-api-rails
sh ./lib/scripts/finish_rails.sh
sh ./lib/scripts/finish_resque.sh
sleep 5s
sh ./lib/scripts/start_resque.sh
sh ./lib/scripts/start_rails.sh
