# oanda-api-rails

OANDA の API を使って為替データを取得してみる

# Commands

### Resqueの設定

Resque, resque-scheduler を God で管理するための設定ファイル作成
```
$ RAILS_ENV=[RAILS_ENV] bundle exec itamae local config/itamae/resque.rb
```

設定ファイル読み込み
```
$ god -c /etc/god/master.conf
```

God から Resque, resque-scheduler の状態確認/起動/再起動/停止
```
$ sudo god status resque-oanda_api_rails
$ sudo god start resque-oanda_api_rails
$ sudo god restart resque-oanda_api_rails
$ sudo god stop resque-oanda_api_rails
```

### ソース更新時の作業

```
bundle
bundle exec rake assets:precompile RAILS_ENV=[RAILS_ENV]
bundle exec pumactl start -F config/puma/[RAILS_ENV].rb
```
