Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  post 'create_user', to: 'registrations#create'

  namespace :api, defaults: { format: :json } do
    resources :records, except: [:new, :edit]
    resources :categories, except: [:new, :edit]

    get 'charts', to: 'charts#index'
  end
end
