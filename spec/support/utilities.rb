# Method used in testing that the title is correct
def full_title(page_title)
	
	# The default title each page should have
	base_title = "Ruby on Rails Tutorial Sample App"

	# If page_title is empty then base title is used.
	if page_title.empty?
		base_title
	# If page_title is not empty than it is added to the
	# base_title to make a custome title.
	else
		# Formats the title with both the base_title and the
		# page_title with | in between.
		"#{base_title} | #{page_title}"
	end
end