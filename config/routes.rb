Rails.application.routes.draw do

  root 'pds_projects#select'
  resources :pds_projects, only: [:new, :show] do
    get :select

    resources :general


    #member do
    resources :pds_syslist
    resources :hw_ic

    EquipmentPanelsController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :equipment_panels, model: table do
        get :index, as: :index, on: :collection, to: table.to_s.pluralize.to_sym
      end
    end

    TechnologyEquipmentController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :technology_equipment, model: table do
        get :index, as: :index, on: :collection, to: table.to_s.pluralize.to_sym
      end
    end

    HardwareController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :hardware, model: table do
        get :index, as: :index, on: :collection, to: table.to_s.pluralize.to_sym
      end
    end

    DisplaySystemsController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :display_systems, model: table do
        get :index, as: :index, on: :collection, to: table.to_s.pluralize.to_sym
      end
    end

    ElectricEquipmentController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :electric_equipment, model: table do
        get :index, as: :index, on: :collection
      end
    end

    RemotesController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :remotes, model: table do
        get :index, as: :index, on: :collection
      end
    end

    ProjectSettingsController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :project_settings, model: table do
        get :index, as: :index, on: :collection, to: table.to_s.pluralize.to_sym
      end
    end

    ServiceController::ACTIONS.each do |table|
      resources table.to_s.pluralize, controller: :service, model: table do
        get :index, as: :index, on: :collection, to: table.to_s.pluralize.to_sym
      end
    end
    #end

    #YAML.load_file('public/data/tables.yml').each do |table, name|
    #  resources table.to_s.pluralize, controller: :general, model: table do
    #    get :index, as: :index, on: :collection
    #  end
    #end
  end

  ServiceController::ACTIONS.each do |table|
    resources table.to_s.pluralize, controller: :service, model: table do
      get :index, as: :index, on: :collection, to: table.to_s.pluralize.to_sym
    end
  end

  #TableList
  YAML.load_file('public/data/tables.yml').each do |table, name|
    resources table.to_s.pluralize, only: [:edit, :update], controller: :general, model: table
  end

  controller :import do
    put :update_all
  end

  resources :users

  devise_for :users, class_name: 'PdsEngineer',
             controllers: { sessions: "users/sessions" },
             path_names: { sign_in: 'login', sign_out: 'logout'},
             path: '/'

  resources :tablelist

  scope :api, module: :api, :defaults => { format: :json } do
    # scope :api, format: true, constraints: { format: 'json' }, module: :api do
    resources :pds_syslists
    resources :hw_ics, only: [:index]
    resources :pds_section_assemblers, only: [:index]
    resources :pds_detectors, only: [:index]
    resources :pds_man_equips, only: [:index]
    resources :hw_peds, only: [:index]
    resources :pds_panels, only: [:index]
    resources :hw_devtypes, only: [:index]
    resources :pds_sds, only: [:index]
    resources :pds_engineers, only: [:index]
    resources :pds_documentations, only: [:index]
    resources :pds_motor_types, only: [:index]

    controller :mass_operations, path: :mass_operations do
      put :update_all
    end

  end

  resource :select_builder

  resources :tblbinaries, only:[]  do
    get 'get_file', :on => :member
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
