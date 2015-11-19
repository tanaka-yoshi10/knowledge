require 'rails_helper'

RSpec.describe User, type: :model do
  describe "stocking" do
    it "stocking?がtrueになること" do
      user = create(:user)
      other_user = create(:user)
      article = create(:article, user_id: other_user.id)

      user.stock!(article)
      expect(user.stocking?(article)).to be_truthy
    end

    it "stocking?がfalseになること" do
      user = create(:user)
      other_user = create(:user)
      article = create(:article, user_id: other_user.id)
      user.stock!(article)

      user.unstock!(article)
      user.reload #これがないとdestoryが反映されない。もっと良い書き方はないか？
      expect(user.stocking?(article)).to be_falsey
    end
  end

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
