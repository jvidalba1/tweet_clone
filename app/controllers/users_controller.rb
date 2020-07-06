class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers, :follow, :unfollow, :finder, :follow_finder]

  def show
    @tweets = @user.tweets
  end

  def finder
  end

  def follow_finder
    @finder_user = User.find_by_username(finder_params[:username])

    if @finder_user
      @user.follow(@finder_user)

      flash[:notice] = "#{@finder_user.username} followed"
      redirect_to user_path(@finder_user.username)
    else
      flash[:alert] = "User not found"
      render :finder
    end
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
    @following = @user.all_following
  end

  def followers
    @followers = @user.followers
  end

  private
    def set_user
      @user = User.find_by_username(params[:username])
    end

    def finder_params
      params.fetch(:finder, :username).permit!
    end
end
