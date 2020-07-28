Rails.application.routes.draw do
  resources :neighborhoods
  resources :businesses
  resources :categories
  root 'welcome#welcome'
  
  get '/auth/google_oauth2/callback', to:'session#omniauth'

  get '/login', to: 'session#new'
  post 'login', to: 'session#create'
  delete '/logout', to: 'session#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resources :users, only: [:index, :show, :edit, :delete]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
