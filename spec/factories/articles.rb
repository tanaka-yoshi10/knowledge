FactoryGirl.define do
  factory :article do
    association :author, factory: :user
    title "MyString"
    body "MyText"
  end
end
