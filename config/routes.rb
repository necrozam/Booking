Rails.application.routes.draw do
  #get 'statics/help'
  get 'sessions/new'
  get 'statics/home'
  get '/users/home',to: "statics#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "statics#home"
  get '/signup',to:"users#new"
  get '/login',to:"sessions#new"
  post '/login',to:"sessions#create"
  delete 'logout',to:"sessions#destroy"
  
  get '/home',to:"statics#home"
  get '/news', to: 'statics#news'
  get '/about', to: 'statics#about'
  get '/contact', to: 'statics#contact'

  resources :microposts, only: [:create, :destroy]
  delete 'logout',to: "sessions#destroy"
  #get 'users/:id/edit' ,to: "users#edit"
  resources :users
  resources :account_activations, only: [:edit]

end
