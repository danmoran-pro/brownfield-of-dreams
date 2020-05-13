Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  get '/auth/github', as: 'github_login'
  get "/auth/github/callback" => "sessions#update"
  # get "/signout" => "sessions#destroy", :as => :signout

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    get "/import_playlist", to: "import#new"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'
  get '/video', to: 'video#show'

  get '/users/invite', to: 'invite#new'
  post '/users/invite', to: 'invite#create'
  get '/users/:id', to: 'users#update'
  resources :users, only: [:new, :create, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]
end
