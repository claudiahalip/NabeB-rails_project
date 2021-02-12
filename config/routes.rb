Rails.application.routes.draw do

  
  root 'welcome#welcome'
  
  get '/auth/google_oauth2/callback', to:'session#omniauth'

  get '/login', to: 'session#new'
  post 'login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get '/user/:id', to: 'users#show', as: 'user'

  resources :businesses
  resources :categories, only: [:new, :create]
  resources :neighborhoods do 
  resources :businesses
  end
 
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match '*unmatched', to: 'application#route_not_found', via: :all
end
