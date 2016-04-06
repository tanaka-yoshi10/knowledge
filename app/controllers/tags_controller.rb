class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def show
    @tag = Tag.find_by!(name: params[:name])
    @articles = Article.tagged_with(params[:name]).includes(:author)
  end
end
