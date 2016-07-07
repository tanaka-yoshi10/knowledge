require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "#index" do
    context "not login" do
      it "ログイン画面に遷移すること" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "login" do
      it "記事一覧が表示されること" do
        user = create(:user)
        old_article = create(:article, title: "old", created_at: "2016-07-02 22:00:00")
        new_article = create(:article, title: "new", created_at: "2016-07-05 22:00:00")
        sign_in user
        get :index
        expect(response).to render_template :index
        expect(assigns(:articles).first).to eq(new_article)
      end
    end
  end
end
