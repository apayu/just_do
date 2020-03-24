Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "tasks#index"
  resources :tasks

  resources :users, only: [:new, :create]
  namespace :admin, path: "heyman" do
    resources :users do
      resources :tasks, only: [:index]
    end
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'session', to: 'sessions#destroy'

  get '/404', to: "errors#not_found"
  get '/500', to: "errors#internal_error"
end
