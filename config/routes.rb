Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  resources :users, only: :create
  resources :sessions, only: :create

  resources :events, except: [:edit, :update] do
    resources :competitors, only: [:index, :create, :destroy]
    resource :eliminations, only: [:show, :create, :destroy]
    resource :semi_finals, only: [:show, :create, :destroy]
    resource :finals, only: [:show, :create, :destroy]
  end
end
