# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :users
  resources :email_parse_logs, controller: :email_parse_log, only: %i[index show retry]
  resources :emails, controller: :email, only: %i[index new create show]
  resources :customers, controller: :customer, only: %i[index show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'email#new'
end
