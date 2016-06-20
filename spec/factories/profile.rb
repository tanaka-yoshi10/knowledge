FactoryGirl.define do
  factory :profile do
    association :user, factory: :user
  end
end
