# oanda-api-rails

OANDA の API を使って為替データを取得してみる

# Commands

Resque, resque-scheduler を God で管理するための設定ファイル作成
```
$ RAILS_ENV=[RAILS_ENV] bundle exec itamae local config/itamae/resque.rb
```

以下のファイルを作成

`/etc/god/master.conf`
```
Dir.glob('/etc/god/*.god') do |config|
  God.load config
end
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
