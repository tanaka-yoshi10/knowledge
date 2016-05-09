class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :require_my_profile, only: [:edit, :update, :create]
  before_action :set_profile, only: [:show, :edit, :update]

  def show
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
    def set_user
      @user = User.find(params[:user_id])
    end

    def require_my_profile
      if @user != current_user
        redirect_to @user, notice: 'プロフィールを編集できるのは本人のみです'
      end
    end

    def set_profile
      @profile = @user.profile || @user.build_profile
    end

    def profile_params
      params.require(:profile).permit(:user_id, :first_name, :last_name, :blog_url, :organization, :introducion, :qiita_id)
    end
end
