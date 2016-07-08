require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#articles" do
    it "記事一覧が表示されること" do
      user = create(:user)
      other_user = create(:user)
      old_article = create(:article, title: "old", created_at: "2016-07-02 22:00:00", author: user)
      new_article = create(:article, title: "new", created_at: "2016-07-05 22:00:00", author: user)
      other_user_article = create(:article, title: "other", created_at: "2016-07-07 22:00:00", author: other_user)

      get :articles, id: user

      expect(response).to render_template :articles
      expect(assigns(:articles).first).to eq(new_article)
    end
  end
end
