Rails.application.routes.draw do
  devise_for :users
  get 'money', to: 'money_records#index', as: :money
  post 'money', to: 'money_records#create'

  get 'timer', to: 'time_records#index', as: :timer
  post 'timer', to: 'time_records#create'

  resources :projects, except: [:edit, :update]

  root to: 'pages#dashboard'
end
