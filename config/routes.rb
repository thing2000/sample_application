SampleApplication::Application.routes.draw do

  # Setup the REST URIs for users
  resources :users

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
  # contact. This loads the new.html.erb page.
  # It also creates two names routes, signup_path
  # and signup_url.
   match '/signup', to: 'users#new'
end