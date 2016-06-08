class RelationshipsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def create
    current_user.follow!(@user)
    # TODO: エラー時の考慮
  end

  def destroy
    current_user.unfollow!(@user)
    # TODO: エラー時の考慮

    # [review] viewの内容が同じであれば以下のようにしてviewを1つにしたほうがDRYです
    # render :create
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
