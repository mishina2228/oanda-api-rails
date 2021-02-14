[![CircleCI](https://circleci.com/gh/mishina2228/oanda-api-rails.svg?style=svg)](https://circleci.com/gh/mishina2228/oanda-api-rails)
[![Maintainability](https://api.codeclimate.com/v1/badges/b6b9044754816afc195c/maintainability)](https://codeclimate.com/github/mishina2228/oanda-api-rails/maintainability)
[![codecov](https://codecov.io/gh/mishina2228/oanda-api-rails/branch/master/graph/badge.svg)](https://codecov.io/gh/mishina2228/oanda-api-rails)
[![GitHub license](https://img.shields.io/github/license/mishina2228/oanda-api-rails)](https://github.com/mishina2228/oanda-api-rails/blob/master/LICENSE)

# oanda-api-rails

Get exchange data using OANDA API

## Prerequisites

- Ruby 2.5+
- Node.js 10.22.1+ || 12+ || 14+
- Yarn 1.x+

## Installation

### Set up Rails app

First, install the gems and javascript packages required by the application:
```
bundle
yarn
```
Next, execute the database migrations/schema setup:
```
bundle exec rails db:setup
```

### Resque settings

Create a configuration file to manage [Resque](https://github.com/resque/resque) and [resque-scheduler](https://github.com/resque/resque-scheduler) with [God](http://godrb.com/)
```
RAILS_ENV=[RAILS_ENV] bundle exec itamae local config/itamae/resque.rb
```

Load configuration file
```
god -c /etc/god/master.conf
```

Resque, resque-scheduler operation with God
* check the status
* start
* restart
* stop
```
god status resque-oanda_api_rails
god start resque-oanda_api_rails
god restart resque-oanda_api_rails
god stop resque-oanda_api_rails
```

### Start the app

```
bundle exec rails assets:precompile RAILS_ENV=[RAILS_ENV]
bundle exec pumactl start -e [RAILS_ENV]
```

# Configuration Files

### Notify when Resque job failed

If a Resque job fails, a notification email will be sent.  
Please fill in the settings of email to config/mail.yml .  
The following is an example when sending from Gmail:

```
production:
  delivery_method: :smtp
  smtp_settings:
    address: 'smtp.gmail.com'
    port: 587
    domain: 'gmail.com'
    user_name: [USER_NAME]
    password: [PASSWORD]
    authentication: 'plain'
    enable_starttls_auto: true
  recipients:
    - [EMAIL_ADDRESS]
```
