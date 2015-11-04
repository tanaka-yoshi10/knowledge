class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all.includes(:user) # TODO: 公開のみにする
    @stocked_articles = Article.stocked_by(current_user).includes(:user)
  end
end
