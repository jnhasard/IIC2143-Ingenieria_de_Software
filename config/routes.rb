Rails.application.routes.draw do
  get 'activities/index'
  # get 'forums/new', to: 'forums#desuscribir'
  get 'welcome/index'
  post 'forums/desuscribir', to: 'forums#desuscribir', as: 'desuscribir'
  post 'forums/suscribir', to: 'forums#suscribir', as: 'suscribir'
  devise_for :users
  resources :activities
  # resources :publicaciones
  #resources :publications do  #agregué esto
    #member do
      #put "like" => "publications#upvote"
      #put "unlike" => "publications#downvote"
    #end
  	#resources :comments, only: [:create, :destroy, :update]
    #resources :comments do
      #member do
        #put "like" => "comments#upvote"
        #put "unlike" => "comments#downvote"
      #end
    #end
  #end

  #resources :comments do
    #member do
      #put "like" => "comments#upvote"
      #put "unlike" => "comments#downvote"
    #end
  #end

  resources :forums do
  	resources :publications, only: [:create, :destroy, :update]
    resources :publications do  #agregué esto
      member do
        put "like" => "publications#upvote"
        put "unlike" => "publications#downvote"
      end
      resources :comments, only: [:create, :destroy, :update]
      resources :comments do
        member do
          put "like" => "comments#upvote"
          put "unlike" => "comments#downvote"
        end
      end
    end
  end
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
