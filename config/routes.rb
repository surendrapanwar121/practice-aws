Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homes#index'

  resources :posts
  # resources :registrations, only: [:new, :create]
  get "/registration" => "registrations#new", as: :registration
  post "/registration" => "registrations#create"
  resources :users
  get "/login(.:format)" => "sessions#new", as: :login
  post "/login(.:format)" => "sessions#create"
  get "/logout(.:format)" => "sessions#destroy", as: :logout
end
