Rails.application.routes.draw do
  root "stories#new"

  resources :stories, :questions
end
