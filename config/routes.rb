Rails.application.routes.draw do
  root 'welcome#index'
  
  devise_for :users
  resources :wikis do
    resources :collaborators, only: [:new, :destroy]
    post '/share_wiki' => 'collaborators#share', as: :share_wiki
  end
  resources :charges, only: [:new, :create]
  resources :users, only: [:update, :show, :index] do
    post '/downgrade-plan' => 'users#downgrade', as: :downgrade_plan
  end
  
end
