FactoryGirl.define do

  factory :user do

    sequence(:email) {|n| "joe#{n}@example.com" }
    #email "joe@example.com"
    password "password"
    password_confirmation "password"

  end

  factory :trip do
    name "My Trip"
    user
  end



end