Rails.application.routes.draw do
  devise_for :users
  get 'money', to: 'money_records#index', as: :money

  scope 'timer' do
    resources :records, controller: 'time_records', except: [:new, :show]
    # get 'timer/records/weekly', to: 'time_records#weekly_report', as: :timer_weekly

    post   ':id/finish', to: 'timers#destroy'
    delete ':id',        to: 'timers#destroy'
    post   ':id/:act',   to: 'timers#update', constraints: { act10n: /play|pause/ }
    match  ':id',        to: 'timers#update',  via: [:post, :patch, :put]
    post   '/',          to: 'timers#create'
    get    '/',          to: 'timers#index', as: :timers
  end

  resources :projects, except: [:edit, :update]

  root to: 'pages#dashboard'
end
