# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :users
  # devise_for :users,
  #            controllers: {
  #              sessions: 'users/sessions',
  #              registrations: 'users/registrations'
  #            }

  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post 'auth/sign_up', to: 'registrations#create'
        post 'auth/sign_in', to: 'sessions#create'
        delete 'auth/sign_out', to: 'sessions#destroy'
      end
      resources :assets, only: [:index]
    end
  end

  # Defines the root path route ("/")
  root 'home#index'
end
