class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]

  def show
  end

  def new
    @profile = current_user.build_profile
  end

  def edit
  end

  def create
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      redirect_to user_profile_path(@profile.user), notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  def update
    if @profile.update(profile_params)
      redirect_to user_profile_path(@profile.user), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_profile
      @profile = current_user.profile || current_user.build_profile
    end

    def profile_params
      params.require(:profile).permit(:user_id, :first_name, :last_name, :blog_url, :organization, :introducion, :qiita_id)
    end
end
