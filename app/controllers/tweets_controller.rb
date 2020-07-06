class TweetsController < ApplicationController
  before_action :set_user, only: [:new, :create]

  def new
    @tweet = @user.tweets.new
  end

  def create
    @tweet = @user.tweets.new(tweet_params)

    if @tweet.save
      flash[:notice] = "Tweet created successfully."
      redirect_to root_path
    else
      flash[:alert] = "Error posting tweet."
      render :new
    end
  end

  private

    def set_user
      @user = User.find_by_username(params[:user_username])
    end

    def tweet_params
      params.fetch(:tweet, :body).permit!
    end
end
