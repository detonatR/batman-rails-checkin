BatmanRailsCheckin::Application.routes.draw do
  resources :invitees, except: :edit

  class FormatTest
    attr_accessor :mime_type

    def initialize(format)
      @mime_type = Mime::Type.lookup_by_extension(format)
    end

    def matches?(request)
      request.format == mime_type
    end
  end


  resources :projects, except: :edit, :constraints => FormatTest.new(:json) do
    resources :checkins, :except => :edit, :constraints => FormatTest.new(:json)
    resources :users, only: [:index, :show, :create], :constraints => FormatTest.new(:json)
    resources :invitees, only: [:index, :destroy], :constraints => FormatTest.new(:json)
  end

  put 'users', to: 'users#update', :constraints => FormatTest.new(:json)
  delete 'users', to: 'users#destroy', :constraints => FormatTest.new(:json)
  get 'users/typeahead', to: 'users#typeahead', constraints: FormatTest.new(:json)
  get 'users/current', to: 'users#current', constraints: FormatTest.new(:json)
  get 'users/oauth', to: 'users#oauth', :constraints => FormatTest.new(:html)
  post 'users/oauth', to: 'users#oauth', :constraints => FormatTest.new(:html)

  get '/*foo', :to => 'main#index', :constraints => FormatTest.new(:html)
  root :to => 'main#index', :constraints => FormatTest.new(:html)

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
