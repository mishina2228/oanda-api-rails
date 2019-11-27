# oanda-api-rails

Get exchange data using OANDA API

# Commands

### Resque settings

Create a configuration file to manage [Resque](https://github.com/resque/resque) and [resque-scheduler](https://github.com/resque/resque-scheduler) with [God](http://godrb.com/)
```
$ RAILS_ENV=[RAILS_ENV] bundle exec itamae local config/itamae/resque.rb
```

Load configuration file
```
$ god -c /etc/god/master.conf
```

Resque, resque-scheduler operation with God
* check the status
* start
* restart
* stop
```
$ sudo god status resque-oanda_api_rails
$ sudo god start resque-oanda_api_rails
$ sudo god restart resque-oanda_api_rails
$ sudo god stop resque-oanda_api_rails
```

### After source update

```
bundle
bundle exec rails assets:precompile RAILS_ENV=[RAILS_ENV]
bundle exec pumactl start -F config/puma/[RAILS_ENV].rb
```
