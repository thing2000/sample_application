SampleApplication::Application.routes.draw do
  # Route for the home action in the 
  # static_pages_coltroller.
  get "static_pages/home"

  # Route for the help action in the
  # static_page_controller.
  get "static_pages/help"

  # Route for the about action in the
  # static_page_controller
  get "static_pages/about"

end