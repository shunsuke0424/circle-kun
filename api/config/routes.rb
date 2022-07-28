Rails.application.routes.draw do
  get 'health_check', to: 'health_check#index'

  resources :companies, only: %i[index show create]
  resources :athletics, only: %i[index]
  resources :cultures, only: %i[index]
  resources :arts, only: %i[index]
  resources :keywords, only: %i[index]
  resources :places, only: :index
  resources :activity_days, only: :index
end
