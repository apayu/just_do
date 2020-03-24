Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tasks#index"
  resources :tasks

  resources :users, only: [:new, :create]
  namespace :admin, path: "heyman" do
    resources :users
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'session', to: 'sessions#destroy'
end
