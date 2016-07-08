FactoryGirl.define do
  factory :comment do
    association :user
    association :article
    body "Comment"
  end
end
