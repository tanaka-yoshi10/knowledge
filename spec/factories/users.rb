FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "test#{n}@example.com" }
    sequence(:username) {|n| "user#{n}" }
    password "foobar00"
    password_confirmation "foobar00"
  end

end
