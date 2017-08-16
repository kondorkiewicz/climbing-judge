Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  resources :users, only: :create
  resources :sessions, only: :create
  
  resources :events do 
    member do 
      get 'competitors'
      get 'delete_competitor'
      get 'add_competitor'
    end 
  end 
  
  resources :competitors
end
