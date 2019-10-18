Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'forgot_password', to: 'devise/passwords#new'
    get 'reset_password', to: 'devise/passwords#edit'
  end

  resources :users
  resources :roles

  root to: "user#show"
end
