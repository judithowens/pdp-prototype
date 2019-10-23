Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  
  devise_scope :users do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    get 'forgot_password', to: 'devise/passwords#new'
    get 'reset_password', to: 'devise/passwords#edit'
  end

  resources :users do
    resources :qualifications
  end

  resources :roles

  root to: "users#show"
end
