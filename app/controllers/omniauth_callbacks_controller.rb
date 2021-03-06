class OmniauthCallbacksController < ApplicationController
  def all
    @user = User.from_omniauth(request.env["omniauth.auth"])#.except("extra")
    # TODO: extraとかまだよくわかっていない。要調査

    if @user.persisted?
      flash.notice = "ログインしました！"
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
  alias_method :github, :all
end
