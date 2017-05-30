Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  devise_for :users, only: :session
  root "pages#index"
  resources :companies, only: :show
  namespace :education do
    namespace :management do
      resources :groups, only: :index
      resources :permissions, only: :create
      resources :abouts, only: [:index, :update]
      resources :feedbacks, only: [:index, :destroy]
      resources :learning_programs, only: [:index, :update]
      resources :techniques, except: :show
      resource :group_users, only: :destroy
      resources :group_users, only: [:create, :index]
      resources :users, only: [:index, :update, :create]
      resources :categories, except: [:show, :new, :edit]
      root "users#index"
    end
    root "home#index"
    resources :projects do
      resources :comments, except: [:show, :new, :index]
      resources :rates, only: :create
    end
    resources :trainers, only: :index
    resources :trainings
    resources :techniques, only: :index
    resources :feedbacks, only: [:new, :create]
    resources :courses
    resources :trainings, only: :index
    resources :posts do
      resources :comment_posts, except: [:show, :new, :index]
      resources :rates, only: :create
    end
    resources :course_members, only: [:create, :destroy]
    resources :users, only: :show
    resources :images, only: :create
    resources :project_members, only: [:create, :destroy]
  end

  namespace :employer do
    resources :companies, only: [:edit, :update] do
      resources :jobs, except: [:show]
      resources :dashboards, only: :index
      resources :teams
      resources :team_introductions, only: [:create, :new]
      resources :candidates, only: [:index, :update]
      resources :articles, except: [:show]
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
  resources :friend_ships, only: [:create, :destroy, :update]
  resources :info_users, only: :update
  resources :user_portfolios, except: [:index, :show]
  resources :awards, except: [:index, :show]
  resources :user_works, except: :show
  resources :user_educations, except: :show
  resources :user_links, except: [:show, :index]
  resources :user_posts do
    resources :comments, except: [:show, :new, :index]
    resources :likes, only: [:create, :destroy]
  end
  resources :user_projects, except: [:index, :show]
  resources :certificates, except: [:index, :show]
  resources :user_languages, except: :show
  resources :user_social_networks, only: :create
  resource :user_social_networks, only: :update
end
