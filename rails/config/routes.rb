require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  mount ActionCable.server => '/cable'

  resources :posts, only: %i[index show new create destroy]

  resources :configurations, only: [] do
    get :ios_v1, on: :collection
    get :android_v1, on: :collection
  end

  root "posts#new"
end
