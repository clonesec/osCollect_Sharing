OscollectShare::Application.routes.draw do
  resources :sessions
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"

  resources :password_resets

  resources :users

  resources :shares

  resources :api_keys

  root :to => "api_keys#index"
end
