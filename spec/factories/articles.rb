FactoryGirl.define do
  factory :article do
    association :author, factory: :user
    title "MyString"
    body "MyText"
    status :published
  end
end
