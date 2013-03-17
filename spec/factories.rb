FactoryGirl.define do
	factory :user do

		# Will cycle through names every time its called thus
		# creating a unique name
		sequence(:name)  { |n| "Person #{n}" }

		# Will cycle through email every time its called thus
		# creating a unique email
    	sequence(:email) { |n| "person_#{n}@example.com"}  
		password "password"
		password_confirmation "password"

		factory :admin do
			admin true
		end
	end

	
	# Create a micropost for testing
	factory :micropost do
		content "Lorem ipsum"
		user
	end
end