class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.feed.includes(:author).page(params[:page])
  end

  def drafts
    @articles = current_user.articles.draft.includes(:author).page(params[:page])
  end

  def mine
    @articles = current_user.articles.published.includes(:author).page(params[:page])
  end

  def stocks
    @articles = current_user.stocking_articles.published.includes(:author).page(params[:page])
  end
end
