module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
    
    # Takes user email and downcases it and converts it to a 
    # MD5 hexdigest 
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    
    # Creates url for gravatar website and adds MD5 hexdigest to it
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    
    # Gets the image from the website and creates a image tag to be
    # returned from the method to website.
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
