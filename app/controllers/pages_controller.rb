class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.feed.order(:created_at).reverse_order.includes([:author, :tags]).page(params[:page])
  end

  def drafts
    @articles = current_user.articles.draft.order(:created_at).reverse_order.includes(:author).page(params[:page])
  end
end
