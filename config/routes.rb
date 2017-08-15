Rails.application.routes.draw do
  devise_for :users
  get 'money', to: 'money_records#index', as: :money

  match 'timer/new',        to: 'time_records#timer_run',    via: [:get, :post]
  match 'timer/:id/run',    to: 'time_records#timer_run',    via: [:get, :post]
  match 'timer/:id/pause',  to: 'time_records#timer_pause',  via: [:get, :post]
  match 'timer/:id/finish', to: 'time_records#timer_finish', via: [:get, :post]
  get  'timer', to: 'time_records#index', as: :timer
  post 'timer', to: 'time_records#create'

  resources :projects, except: [:edit, :update]

  root to: 'pages#dashboard'
end
