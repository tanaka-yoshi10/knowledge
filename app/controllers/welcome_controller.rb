class WelcomeController < ApplicationController
  before_action :authenticate_user!

  # TODO: もう少しすっきりかけないか
  def index
    @articles = current_user.feed.order(created_at: :desc).includes(:author).page(params[:page])
  end

  def drafts
    @articles = current_user.articles.draft.order(created_at: :desc).includes(:author).page(params[:page])
  end

  def mine
    @articles = current_user.articles.published.order(created_at: :desc).includes(:author).page(params[:page])
  end

  def stocks
    @articles = current_user.stocking_articles.published.order(created_at: :desc).includes(:author).page(params[:page])
  end
end
