module ApplicationHelper
	# Returns the full title on a per-page basis.
	# It will return a formates title even if page
	# does not supply one.
	
	# Define class named full_title
	def full_title(page_title)
		
		# Will be used a default title
		base_title = "Ruby on Rails Tutorial Sample App"

		# If page title is empty base title will be used
		if page_title.empty?
			base_title
		# Else base_title and page title will be formated together
		else
			"#{base_title} | #{page_title}"
		end
	end
end
