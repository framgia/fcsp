Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users, controllers: {omniauth_callbacks: :omniauth_callbacks}
  root "pages#index"
  resources :tms_synchronize, only: :index
  resources :companies, only: [:show, :create]

  namespace :education do
    namespace :management do
      resources :groups, only: :index
      resources :permissions, only: :create
      resource :group_users, only: :destroy
      resources :group_users, only: [:create, :index]
      resources :users, only: [:index, :update, :create]
      root "users#index"
    end
    root "home#index"
    resources :users, only: :show
    resources :images, only: :create
  end

  namespace :employer do
    resources :companies, only: [:edit, :update] do
      delete "jobs", to: "jobs#destroy"
      resources :jobs, except: [:show]
      resources :dashboards, only: :index
      resources :teams
      resources :candidates, only: [:index, :update, :show]
      delete "candidates", to: "candidates#destroy"
    end
  end

  namespace :admin do
    resources :dashboards, only: :index
    root "dashboards#index"
    resources :companies, only: [:new, :create, :show]
    resources :users, only: [:new, :create]
  end

  resources :jobs, only: [:index, :show]
  resources :share_jobs, only: [:create, :destroy]
  resources :candidates, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :follow_companies, only: [:create, :destroy]
  resources :users, only: [:show, :new]
  resources :user_avatars, only: :create
  resource :user_avatars, only: :update
  resources :companies_avatars, only: [:create, :update]
  resources :companies_cover
  resources :user_covers, only: :create
  resource :user_covers, only: :update
  resources :info_users, only: :update
  resources :user_educations, except: :show
  resources :user_languages, except: :show
  resources :user_social_networks, only: :create
  resource :user_social_networks, only: :update
  resources :user_languages
  resources :skills, only: :index
end
