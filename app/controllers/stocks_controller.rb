class StocksController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

  def create
    current_user.stock!(@article)
    # TODO: エラー時の考慮
  end

  def destroy
    current_user.unstock!(@article)
    # TODO: エラー時の考慮
    render :create
  end

  private
  def set_article
    @article = Article.find(params[:article_id])
  end
end
