Rails.application.routes.draw do
  devise_for :users
  get 'money', to: 'money_records#index', as: :money

  scope 'timer' do
    get 'records/weekly', to: 'time_records#weekly_report', as: :time_records_weekly
    resources :records, controller: 'time_records', except: [:new, :show], as: 'time_records'

    post   ':id/finish', to: 'timers#destroy'
    delete ':id',        to: 'timers#destroy'
    post   ':id/:act',   to: 'timers#update', constraints: { act: /play|pause/ }
    match  ':id',        to: 'timers#update',  via: [:post, :patch, :put]
    post   '/',          to: 'timers#create'
    get    '/',          to: 'timers#index', as: :timers
  end

  resources :projects, except: [:edit, :update]

  root to: 'pages#dashboard'
end
