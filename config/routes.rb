Rails.application.routes.draw do
  get 'timer', to: 'time_records#index', as: :timer
  post 'timer', to: 'time_records#create'

  resources :projects, except: [:edit, :update]

  root to: 'pages#dashboard'
end
