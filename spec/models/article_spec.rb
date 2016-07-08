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

  describe "#tag_list" do
    let(:article) { create(:article) }
    subject { article.tag_list }

    context 'タグを追加したとき' do
      before {
        article.tag_list = "Rails, Ruby"
        article.save!
      }
      it { is_expected.to eq ["Rails", "Ruby"] }
    end

    context 'タグを削除したとき' do
      before {
        article.tag_list = "Rails, Ruby"
        article.save!
        article.tag_list = "Rails"
        article.save!
      }
      it { is_expected.to eq ["Rails"] }
    end
  end
end
