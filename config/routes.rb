Rails.application.routes.draw do
  devise_for :users, only: :session
  get "/pages/*page" => "pages#show"
  root "pages#home"
  resources :companies, only: :show
  namespace :education do
    namespace :management do
      resources :groups, only: :index
      resources :permissions, only: :create
    end
    root "home#index"
    resources :projects do
      resources :comments
    end
    resources :trainings
    resources :techniques
    resources :feedbacks, only: [:new, :create]
    resources :courses
    resources :trainings, only: :index
    resources :posts do
      resources :comment_posts, except: [:index, :show]
    end
    resources :course_members, only: [:create, :destroy]
    resources :users, only: :show
    resources :images
  end

  namespace :employer do
    resources :companies do
      resources :jobs
      resources :dashboards, only: :index
      resources :team_introductions, only: [:create, :new]
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
end
