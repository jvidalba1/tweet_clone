class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :following, :followers, :follow, :unfollow, :finder, :follow_finder]
  before_action :check_authorization, only: [:finder, :follow_finder]

  def show
    @tweets = @user.tweets.order(created_at: :desc).paginate(page: params[:page])
  end

  def finder
  end

  def follow_finder
    result = Finder.new(finder_params, @user).call

    if result.success?
      flash[:notice] = "You're following #{result.user.username} now."
      redirect_to user_path(result.user.username)
    else
      flash[:alert] = result.error
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
    @following = @user.all_following.paginate(page: params[:page])
  end

  def followers
    @followers = @user.followers.paginate(page: params[:page])
  end

  private

    def check_authorization
      raise Pundit::NotAuthorizedError unless @user == current_user
    end

    def set_user
      @user = User.find_by_username(params[:username])
      raise ActiveRecord::RecordNotFound unless @user
    end

    def finder_params
      params.fetch(:finder, :username).permit!
    end
end
