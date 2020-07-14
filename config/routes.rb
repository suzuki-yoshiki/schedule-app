Rails.application.routes.draw do
  #resources :posts
  get 'homeworks/show'
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  get '/search', to: 'users#search'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    collection { post :import }
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
    end
  resources :homeworks do
    member do
      get 'edit_work_info'
      patch 'update_work_info'
      get 'new_homework_info'
      patch 'update_home_work'
      get 'homework_all'
      get 'homework_yet'
    end
  end
  resources :schedules do
  post '/callback' => 'linebot#callback'
  get '/schedules.json', to: 'schedules#index'
  end
  resources :videos do
  end
end
end