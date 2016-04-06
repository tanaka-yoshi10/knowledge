class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all.includes(:author) # TODO: 公開のみにする
    @stocking_articles = current_user.stocking_articles.includes(:author)
  end
end
