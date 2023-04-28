Rails.application.routes.draw do
  devise_for :users
  resources :projects do
    resources :comments, only: [:create]
  end
  
  resources :comments

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # defines root path route
  #root
  root "projects#index"
end
