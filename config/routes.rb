Styledujour::Application.routes.draw do

  resources :stylists do
    resources :clients do
      collection do
        get 'statuses'
      end
      member do
        get 'status'
      end
    end
  end


  resources :tasks


 devise_for :users, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}

  devise_for :users, :controllers=>{:sessions=>"api/v1/sessions"}, :skip=>[:sessions] do
    match 'api/v1/auth_token'=>"api/v1/sessions#get_authentication_token", :via=>:get
    match 'api/v1/login'=>'api/v1/sessions#create', :via=>[:get, :post]
    get 'api/v1/logout'=>'api/v1/sessions#destroy', :via=>:destroy_user_session
    match 'api/v1/facebook'=>'api/v1/omniauth_callbacks#facebook', :via=>[:get]
  end

  namespace :api do
    namespace :v1 do
      resources :users, :except=>[:index, :show, :edit, :update, :delete] do
        member do
          get 'contacts'
          get 'facebook_invites'
          get 'check_facebook_friend'
          get 'friendship_requests'
          get 'contacts_in_network'
          post 'request_friendships'
          post 'accept_friendship'
        end

      end
      post 'hcit/ask_user'
      get 'hcit/answer_queue'
      get 'hcit/my_asks_count'
      get 'hcit/my_scores_count'
      get 'hcit/my_badges'
    end
  end

  match "hcit" => "hcit#index"
  get "hcit/index"
  get "hcit/getid"
  get "hcit/submit_link"
  get "hcit/get_page_details"
  post "hcit/fb_request"
  get "hcit/my_asks"
  get "hcit/my_scores"
  get "hcit/browse"
  get "hcit/how_cute"
  get "welcome/index"
  
  match 'facebook_app' => 'facebook_app#index'
  
  resources :linked_clothing_items do
    member do
      get 'invite_friends'
      get 'confirmation'
    end
  end

  resources :clothing_items, :except=>[:edit, :delete] do
    member do
      get 'invite_friends'
      get 'bookmark'
      get 'hcit_form'
      post 'hcit_score'
      get 'user_scored_clothing_item'
      post 'add_to_closet'
      post 'bookmark'
    end
    collection do
      get 'bookmarked'
    end
  end

  resources :users do
    resources :closets do
      resources :outfits do
        
      end
    end
  end


  resources :closets do
    resources :outfits do
    end
    resources :clothing_items do
    end

  end
  # The priority is based upon order of creation:
  # first created -> highest priority.
  #devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
