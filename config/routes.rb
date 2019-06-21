require 'resque/scheduler/server'
require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: '/resque'

  resources :resque_schedules, only: %w(index show edit update) do
    collection do
      put :setup_all
    end
  end
  resources :candle_information, only: %w(index)

  root 'resque_schedules#index'
end
