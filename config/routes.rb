Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users, controllers: {omniauth_callbacks: :omniauth_callbacks,
    sessions: :sessions}
  root "pages#index"
  resources :tms_synchronize, only: :index

  namespace :setting do
    root "profiles#index"
    resource :share_profiles, only: :create
  end

  resources :jobs, only: %i(index show)
  resources :users, except: %i(index destroy create) do
    resources :courses do
      resources :subjects
    end
    member do
      post :follow
      delete :unfollow
      patch :update_auto_synchronize
    end
    get :autocomplete_skill_name, on: :collection
  end

  resource :user_avatars, only: %i(create update)
  resource :user_covers, only: %i(create update)
  resources :info_users, only: %i(update)
  resources :user_languages, except: :show
  resources :skills
  resources :skill_users, only: %i(update destroy)
  resources :conversations, only: :create do
    member do
      post :close
    end
    resources :messages, only: :create
  end

  match "*path", to: "application#routing_error", via: :all
end
