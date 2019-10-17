Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :roles

  root to: "user#show"
end
