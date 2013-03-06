SampleApplication::Application.routes.draw do
  get "users/new"

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
end