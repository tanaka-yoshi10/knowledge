require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is valid with a title and body' do
    user = create(:user)
    article = build(:article, author: user)
    expect(article).to be_valid
  end

  it 'is invalid without a title' do
    user = create(:user)
    article = build(:article, title: nil, author: user)
    expect(article).to be_invalid
  end
end
