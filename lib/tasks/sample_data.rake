namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "admin@deri.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = Users.all(limit: 6)
    
    value = 0
    50.times do
      consumer = Faker::Lorem.sentence(1)
      consumer_secret = Faker::Lorem.sentence(1)
      access = Faker::Lorem.sentence(1)
      access_secret = Faker::Lorem.sentence(1)
      value = value + 1
      value_str = "name#{value}"
      users.each do |user| 
        Credential.create!(consumer: consumer,
                                        consumer_secret: consumer_secret,
                                        access: access,
                                        access_secret: access_secret,
                                        user_id: user.id,
                                        name: value_str)
      end
    end

    50.times do
      query = Faker::Lorem.sentence(5)
      users.each do |user|
        credential = Credential.find_by_user_id(user.id) 
        Search.create!(query: query, user_id: user.id,
                                        credential_id: credential.id  ) 
      end
    end
  end
end
