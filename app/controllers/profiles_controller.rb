class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to current_user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_profile
    @profile = current_user.profile || current_user.build_profile
  end

  def profile_params
    params.require(:profile).permit(:user_id, :first_name, :last_name, :blog_url, :organization, :introduction, :qiita_id)
  end
end
