class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.feed.order(:created_at).reverse_order.includes([:author, :tags]).page(params[:page])
  end

  def drafts
    @articles = current_user.articles.draft.order(:created_at).reverse_order.includes([:author,:tags]).page(params[:page])
  end

  def mine
    @articles = current_user.articles.published.order(:created_at).reverse_order.includes([:author, :tags]).page(params[:page])
  end
end
