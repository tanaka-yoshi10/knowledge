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
end
