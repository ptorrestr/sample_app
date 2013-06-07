FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :search do
    query "Lorem ipsum"
    user
    credential
  end

  factory :credential do
    consumer "foobar"
    consumer_secret "foobar"
    access "foobar"
    access_secret "foobar"
    name "foobar"
  end
end
