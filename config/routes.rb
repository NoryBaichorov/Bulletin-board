# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    delete 'auth/logout', to: 'auth#logout'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resources :bulletins, except: :destroy do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    get '/profile', to: 'profile#index'

    namespace :admin do
      resources :categories, except: :show
      resources :bulletins, only: :index do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
      root 'home#index'
    end
  end
end
