require 'resque/scheduler/server'
require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: '/resque'

  resources :resque_schedules, only: %w(index edit update) do
    collection do
      put :setup_all
      get :schedule
    end
  end
  resources :candle_information, only: %w(index)
  resources :candle_access, only: %w(index) do
    collection do
      put :access
    end
  end

  root 'resque_schedules#index'
end
