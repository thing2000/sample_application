namespace :db do
  desc "Fill database with sample data"
  
  # Populate database with test users
  task populate: :environment do
    
    # Create a user with preset variables and assign
    # it to the variable admin.
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")

    # Toggle that value of the admin attribute from
    # its defaule false to true.
    admin.toggle!(:admin)

    # Create 99 users with generated names and emails
    # but all will have that same password.
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end