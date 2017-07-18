Rails.application.routes.draw do

  concern :api_base do
    devise_for :users
    post 'auth_user' => 'authentication#authenticate_user'
    get 'home' => 'application#index'
    resources :destinations do
      resources :reviews
    end
  end

  namespace :v1 do
    concerns :api_base
  end
end
