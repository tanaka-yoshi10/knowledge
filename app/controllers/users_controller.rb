class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def stocks
    @articles = @user.stocking_articles.published.includes(:author).page(params[:page])
  end

  def articles
    @articles = @user.articles.published.includes(:author).page(params[:page])
  end

  def followers
    @followers = @user.followers.page(params[:page])
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
