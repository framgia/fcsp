Rails.application.routes.draw do
  devise_for :users, only: :session
  root "education/home#index"
  resources :companies, only: :show
  resources :team_jobs
  resources :team_introductions
  namespace :education do
    namespace :management do
      resources :groups, only: :index
      resources :permissions, only: :create
      resources :abouts, only: [:index, :update]
      resources :feedbacks, only: [:index, :destroy]
      resources :learning_programs, only: [:index, :update]
      resources :techniques
      resource :group_users, only: :destroy
      resources :group_users, only: [:create, :index]
      resources :users, only: [:index, :update, :create]
      resources :categories, except: [:show, :new, :edit]
      root "users#index"
    end
    root "home#index"
    resources :projects do
      resources :comments
      resources :rates, only: :create
    end
    resources :trainers, only: :index
    resources :trainings
    resources :techniques
    resources :feedbacks, only: [:new, :create]
    resources :courses
    resources :trainings, only: :index
    resources :posts do
      resources :comment_posts, except: [:index, :show]
      resources :rates, only: :create
    end
    resources :course_members, only: [:create, :destroy]
    resources :users, only: :show
    resources :images
    resources :project_members, only: [:create, :destroy]
  end

  namespace :employer do
    resources :companies do
      resources :jobs, except: [:show]
      resources :dashboards, only: :index
      resources :team_introductions, only: [:create, :new]
      resources :candidates, only: :index
    end
  end

  namespace :admin do
    resources :dashboards, only: :index
    root "dashboards#index"
    resources :companies, only: [:new, :create, :show]
    resources :users, only: [:new, :create]
  end

  resources :jobs, only: [:index, :show]
  resources :candidates, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :follow_companies, only: [:create, :destroy]
  resources :users
  resources :user_avatars, only: :create
  resource :user_avatars, only: :update
  resources :companies_avatars
  resources :companies_cover
  resources :user_covers, only: :create
  resource :user_covers, only: :update
  resources :friend_ships, only: [:create, :destroy, :update]
  resources :info_users, only: :update
  resources :user_portfolios, except: [:index, :show]
  resources :awards, except: [:index, :show]
  resources :user_works
  resources :user_educations
end
