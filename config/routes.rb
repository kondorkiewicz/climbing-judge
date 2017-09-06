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
      get 'competitors', controller: 'event_competitors'
      get 'delete_competitor', controller: 'event_competitors'
      get 'add_competitor', controller: 'event_competitors'
      get 'create_eliminations_lists', controller: 'eliminations'
      get 'eliminations', controller: 'eliminations'
      get 'compute_eliminations_results', controller: 'eliminations_results'
      get 'eliminations_results', to: 'eliminations_results#index'
      get 'create_semi_finals_lists', controller: 'semi_finals'
      get 'create_finals_lists', controller: 'finals'
      get 'semi_finals', controller: 'semi_finals'
      get 'finals', controller: 'finals'
      get 'delete_eliminations_lists', controller: 'eliminations'
      get 'delete_eliminations_results', controller: 'eliminations_results'
      get 'delete_semi_finals_lists', controller: 'semi_finals'
      get 'delete_finals_lists', controller: 'finals'
      get 'compute_results', controller: 'results'
    end 
  end 
  
  resources :scores, only: :update
  resources :lists, only: :show
  resources :competitors
  
  get '*path' => redirect('/')
end
