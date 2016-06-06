require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is valid with a title and body' do
    article = build(:article)
    expect(article).to be_valid
  end

  it 'is invalid without a title' do
    article = build(:article, title: nil)
    expect(article).to be_invalid
  end

  it 'is invalid without a body' do
    article = build(:article, body: nil)
    expect(article).to be_invalid
  end

  it 'タグのArrayを返すこと' do
    article = build(:article, tag_list: "iOS, Rails")
    article.save!
    article.reload  #TODO: reloadはなぜ必要なのか？
    expect(article.tag_list).to eq ["iOS", "Rails"]
  end
end
