class TagsController < ApplicationController
  def index
    @tags = Tag.most_used_in_published
  end

  def show
    @tag = Tag.find_by!(name: params[:name])
  end
end
