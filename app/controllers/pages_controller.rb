class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: feed機能
  end

  def drafts
    @articles = current_user.articles.draft.order(:created_at).reverse_order.includes(:author).page(params[:page])
  end
end
