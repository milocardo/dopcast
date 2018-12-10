Rails.application.routes.draw do
  get 'activities/index'
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      post "follow" => "users#follow"
      post "unfollow" => "users#unfollow"
    end
    resources :playlists
    resources :subscriptions
      member do
        get :mentionable
      end
  end

  resources :podcasts do
    resources :episodes, shallow: true
    member do
      put "like" => "podcasts#upvote"
      put "unlike" => "podcasts#downvote"
    end
    member do
      post "follow" => "podcasts#follow"
      post "unfollow" => "podcasts#unfollow"
      get "show_by_id/:id" => "podcasts#show_by_id", as: "show_by_id"

    end
  end

  resources :episodes, only: [] do
    resources :reviews, shallow: true
    member do
      put "like" => "episodes#upvote"
      put "unlike" => "episodes#downvote"
    end
  end

  # match "/podcasts/add_new_comment" => "podcasts#add_new_comment", :as => "add_new_comment_to_podcasts", :via => [:podcast]
  # match "/episodes/add_new_comment" => "episodes#add_new_comment", :as => "add_new_comment_to_episodes", :via => [:episode]


  resources :comments, only: [:create, :destroy]
  resources :activities
  get "/feed" => "activities#feed", as: :feed
  get "/feed/fetch" => "activities#show", as: :fetch_activity
  get "/yours" => "activities#yours", as: :your_actions
end
