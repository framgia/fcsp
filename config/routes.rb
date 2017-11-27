Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users, controllers: {omniauth_callbacks: :omniauth_callbacks,
    sessions: :sessions}
  root "pages#index"
  resources :tms_synchronize, only: :index
  resources :companies, only: %i(show create)

  namespace :education do
    namespace :management do
      resources :groups, only: :index
      resources :permissions, only: :create
      resource :group_users, only: :destroy
      resources :group_users, only: %i(create index)
      resources :users, only: %i(index update create)
      root "users#index"
    end
    root "home#index"
    resources :users, only: :show
    resources :images, only: :create
  end

  namespace :employer do
    resources :companies, only: %i(edit update) do
      delete "jobs", to: "jobs#destroy"
      resources :jobs, except: :show
      resources :dashboards, only: :index
      resources :teams
      resources :candidates, only: %i(index update show)
      resources :trainees, only: :index do
        member do
          post :follow
          delete :unfollow
        end
      end
      delete "candidates", to: "candidates#destroy"
    end
  end

  namespace :admin do
    resources :dashboards, only: :index
    root "dashboards#index"
    resources :companies, only: %i(new create show)
    resources :users, only: %i(new create)
  end

  namespace :setting do
    root "profiles#index"
    resource :share_profiles, only: :create
  end

  resources :jobs, only: %i(index show)
  resources :share_jobs, only: %i(create destroy)
  resources :candidates, only: %i(create destroy)
  resources :bookmarks, only: %i(create destroy)
  resources :follow_companies, only: %i(create destroy)
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
  resources :user_avatars, only: :create
  resource :user_avatars, only: :update
  resources :companies_avatars, only: %i(create update)
  resources :companies_cover
  resources :user_covers, only: :create
  resource :user_covers, only: :update
  resources :info_users, only: %i(update index)
  resources :user_languages, except: :show
  resources :skills, only: %i(index create)
  resources :skill_users, only: %i(update destroy)
  resources :conversations, only: :create do
    member do
      post :close
    end
    resources :messages, only: :create
  end
end
