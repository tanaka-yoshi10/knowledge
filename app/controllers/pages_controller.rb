class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.published.includes(:author)
  end
end
