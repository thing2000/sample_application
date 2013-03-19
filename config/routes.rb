SampleApplication::Application.routes.draw do

  # Setup the REST URIs for users
  resources :users do
    member do
      # pages for viewing user followers and users they follow
      get :following, :followers
    end
  end

  # Setup the REST URIs for sessions. The only restricts
  # the REST to only new, create and destroy leaving
  # edit out as it is not needed.
  resources :sessions, only: [:new, :create, :destroy]

  # Setup the REST UIRs for microposts but only for
  # create and destroy.  
  resources :microposts, only: [:create, :destroy]

  # Routes /home to the static_pages action
  # home. This loads the home.html.erb page.
  # It also creates two names routes, home_path
  # and home_url.
  root to: 'static_pages#home'

  # Routes /help to the static_pages action
  # help. This loads the help.html.erb page.
  # It also creates two names routes, help_path
  # and help_url.
  match '/help', to: 'static_pages#help'

  # Routes /about to the static_pages action
  # about. This loads the about.html.erb page.
  # It also creates two names routes, about_path
  # and about_url.
   match '/about', to: 'static_pages#about'

  # Routes /contact to the static_pages action
  # contact. This loads the contact.html.erb page.
  # It also creates two names routes, contact_path
  # and contact_url.
   match '/contact', to: 'static_pages#contact'

  # Routes /signup to the new action
  # in users. This loads the new.html.erb page.
  # It also creates two names routes, signup_path
  # and signup_url.
   match '/signup', to: 'users#new'

  # Routes /signup to the new action in the sessions
  # controller.
   match '/signin', to: 'sessions#new'

  # Routes /signout to the destroy action in the sessions
  # controller. The via: :delete indicates that the DELETE
  # HTTP request should be used for this. 
   match '/signout', to: 'sessions#destroy', via: :delete
end