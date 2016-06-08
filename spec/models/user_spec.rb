require 'rails_helper'

RSpec.describe User, type: :model do
  # [review] 以下のように書くほうがわかりやすいかなと思います
  describe '#stocking?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:article) { create(:article, author: other_user) }
    subject { user.stocking?(article) }

    context '記事がストックされているとき' do
      before { user.stock!(article) }
      it { is_expected.to be_truthy }
    end

    context '記事がストックされていないとき' do
      it { is_expected.to be_falsey }
    end

    context 'ストック解除されたとき' do
      before do
        user.stock!(article)
        user.unstock!(article)
      end
      it { is_expected.to be_falsey }
    end
  end

  # describe "stocking" do
  #   it "stocking?がtrueになること" do
  #     user = create(:user)
  #     other_user = create(:user)
  #     article = create(:article, author: other_user)
  #
  #     user.stock!(article)
  #     expect(user.stocking?(article)).to be_truthy
  #   end
  #
  #   it "stocking?がfalseになること" do
  #     user = create(:user)
  #     other_user = create(:user)
  #     article = create(:article, author: other_user)
  #     user.stock!(article)
  #
  #     user.unstock!(article)
  #     user.reload #これがないとdestoryが反映されない。もっと良い書き方はないか？
  #     expect(user.stocking?(article)).to be_falsey
  #   end
  # end

  describe "following" do
    it "following?がtrueになること" do
      user = create(:user)
      other_user = create(:user)

      user.follow!(other_user)
      expect(user.following?(other_user)).to be_truthy

      expect(user.followed_users).to include(other_user)
      expect(other_user.followers).to include(user)

      user.unfollow!(other_user)
      expect(user.following?(other_user)).to be_falsey
    end
  end
end
