class TagfollowsController < ApplicationController
  before_action :set_tag
  before_action :authenticate_user!

  def create
    current_user.follow_tag!(@tag)
    # TODO: エラー時の考慮
  end

  def destroy
    current_user.unfollow_tag!(@tag)
    # TODO: エラー時の考慮
    render :create
  end

  private
  def set_tag
    @tag = Tag.find_by!(name: params[:tag_name])
  end
end
