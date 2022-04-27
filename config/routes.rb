require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
