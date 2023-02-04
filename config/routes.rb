# frozen_string_literal: true

require 'resque/scheduler/server'
require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: '/resque'

  resources :resque_schedules, only: [:index, :edit, :update] do
    collection do
      put :setup_all
      get :schedule
    end
  end
  resources :candle_information, only: :index
  resources :candle_access, only: :index do
    collection do
      put :access
    end
  end

  root 'resque_schedules#index'
end
