class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.published.includes(:author)
    @stocking_articles = current_user.stocking_articles.includes(:author)
  end
end
