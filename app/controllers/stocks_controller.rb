class StocksController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

  def create
    current_user.stock!(@article)
    redirect_to @article
  end

  def destroy
    current_user.unstock!(@article)
    redirect_to @article
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
