Asg::Application.routes.draw do

  get "to_pdf/:tour_id/list" => "to_pdf#list"
  get "to_pdf/:tour_id/hotel" => "to_pdf#hotel"

  get "to_rtf/:contract_id" => "contracts#to_rtf"

  root 'main#index'

  post 'filter' => 'clients#filter', as: "filter"
  post 'filter_staff' => 'staffs#filter', as: "filter_staff"
  #post 'send_to_client' => 'clients#send_to_client', as: "send_to_client"

  delete "staffs/:id/all" => "staffs#destroy_for_all"

  get 'change_password' => 'users#change_password', as: "change_password"
  get "login" => "sessions#new", :as => "login"
  get "logout" => "sessions#destroy", :as => "logout"
  get "clients/:client_id/staffs" => "staffs#index"
  get "clients/:client_id/staffs/new" => "staffs#new"
  get "clients/:client_id/contracts" => "contracts#index"
  get "clients/:client_id/contracts/new" => "contracts#new"
  get "countries/:country_id/towns" => "towns#index"
  get "towns/:country_id/new" => "towns#new"
  get "partners/:id/filter" => "partners#index"
  get "clients/:client_id/tours/:filter_id" => "tours#index"
  get "tours/:client_id/new" => "tours#new"
  get "add_hotel" => "tours#add_hotel"
  get "edit_room/:room_id" => "tours#edit_room"
  get "update_room" => "tours#update_room"
  get "add_room/:tour_id/:partner_id" => "tours#add_room"
  get "del_room/:tour_id/:room_id" => "tours#del_room"
  get "select_staff/:tour_id/:room_id" => "tours#select_staff"
  get "add_staff" => "tours#add_staff"
  get "del_staff/:tour_id/:staff_id" => "tours#del_staff"
  get "get_events/:date" => "events#get_events"
  get 'clear_filter' => 'clients#clear_filter', as: "clear_filter"
  get 'clear_filter_staff' => 'staffs#clear_filter', as: "clear_filter_staff"
  get 'create_post/:who' => 'post_dispatches#new'


  resources :users
  resources :notes
  resources :sessions
  resources :sectors
  resources :clients
  resources :staffs
  resources :countries
  resources :towns
  resources :staff_notes
  resources :types_partners
  resources :partners
  resources :visas
  resources :staff_visas
  resources :tours
  resources :tour_notes
  resources :list_staff_tours
  resources :events
  resources :post_dispatches
  resources :post_dispatch_emails
  resources :templates
  resources :contracts

end
