class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def show
    @articles = Article.tagged_with(params[:id]).includes(:user)
  end
end
