ActionController::Routing::Routes.draw do |map|

  # root path
  # TODO: create home page infrastructure (lovd by less?)
  map.root :controller => 'people'

  # people resource
  map.resources :people, :has_many => [:photos, :documents] 
  
  # documents
  map.resources :documents, :member => { :download => :get }
  
  # organizations
  map.resources :organizations, :has_many => [:documents]
   
  # events
  map.resources :events
  
  # core competencies
  map.resources :competencies
  
  # countries / regions
  map.resources :countries
  map.resources :regions
  
  # people browser connections
  map.browse '/people/browse/:browse_by',
              :controller => 'people',
              :action => 'index'
  
  # users /roles
  map.resources :users, :has_many => :roles, :member => { :enable => :put }
  map.resources :roles, :has_many => :users

  map.show_user '/user/:login', :controller => 'users', :action => 'show_by_login'

  # restful_authentication
  map.resources  :sessions
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
