module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  # It takes in two arguments, the first being a user object and
  # second is an otional size for the image. The default is 50.
  def gravatar_for(user, option = { size: 50 })
    
    # Takes user email and downcases it and converts it to a 
    # MD5 hexdigest 
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)

    # Assigns the value of hash size to the variable size.
    size = options[:size]
        
    # Creates url for gravatar website and adds MD5 hexdigest to it.
    # Also passes the size option into the request string.
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    
    # Gets the image from the website and creates a image tag to be
    # returned from the method to website.
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
