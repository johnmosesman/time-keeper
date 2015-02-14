Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  namespace :api do
    resources :records, except: [:new, :edit]
    resources :categories, except: [:new, :edit]
  end
end
