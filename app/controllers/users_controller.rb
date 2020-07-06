class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :follow, :unfollow]

  def show
    @tweets = @user.tweets
  end

  def follow
    current_user.follow(@user)

    flash[:notice] = "#{@user.username} followed"
    redirect_to user_path(@user.username)
  end

  def unfollow
    current_user.stop_following(@user)

    flash[:notice] = "#{@user.username} unfollowed"
    redirect_to user_path(@user.username)
  end

  def following
  end

  def followers
  end

  private
    def set_user
      @user = User.find_by_username(params[:username])
    end

    def user_params
      params.fetch(:user, {})
    end
end
