OscollectShare::Application.routes.draw do
  resources :shares
  root :to => "shares#index"
end
