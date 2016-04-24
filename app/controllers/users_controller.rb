class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def stocks
    @articles = @user.stocking_articles.published.includes(:author).page(params[:page])
    render 'articles/index' # TODO: 共通のlayoutを使うべきかも
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
