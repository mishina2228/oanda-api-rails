require 'resque/scheduler/server'
require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: '/resque'
end
