Rails.application.routes.draw do
  root 'welcome#index'
  
  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :users, only: [:update, :show, :index] do
    post '/downgrade-plan' => 'users#downgrade', as: :downgrade_plan
  end
  
end
