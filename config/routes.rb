Rails.application.routes.draw do
  devise_for :users
  root "stories#new"

  resources :stories, :questions, :users
end
