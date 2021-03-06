namespace :db do
  desc "Fill database with sample data"
  
  # Populate database with test users
  task populate: :environment do

    # Run through each method once
    make_users
    make_microposts
    make_relationships
  end
end

# Generate users  
def make_users
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

# Generate micropost
def make_microposts
  # Create 50 micropost for first 6 users
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

# Create relationships
def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end