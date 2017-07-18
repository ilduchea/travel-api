Rails.application.routes.draw do
  concern :api_base do
    get '/signup' => 'users#new'
    post '/users' => 'users#create'

    get '/signin' => 'sessions#new'
    post '/signin' => 'sessions#create'
    get '/signout' => 'sessions#destroy'
  end

  concern :api_base do
    resources :destinations do
      resources :reviews
    end
  end

  namespace :v1 do
    concerns :api_base
  end
end
