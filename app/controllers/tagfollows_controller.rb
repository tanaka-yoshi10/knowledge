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
    # [review] ここも以下のようにviewを1つにしてDRYにしたいです
    # render :create
  end

  private
  def set_tag
    # [review] find_by! でないとnilエラーが起きる可能性があります。
    @tag = Tag.find_by(name: params[:tag_name])
  end
end
