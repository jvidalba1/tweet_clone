class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:new, :create]

  def new
    @tweet = @user.tweets.new
    authorize @tweet
  end

  def create
    @tweet = @user.tweets.new(tweet_params)
    authorize @tweet

    if @tweet.save
      flash[:notice] = "Tweet created successfully."
      redirect_to user_tweets_path(@user.username)
    else
      flash[:alert] = "Error posting tweet."
      render :new
    end
  end

  def index
    @tweets = TweetsQuery.new(current_user).all.paginate(page: params[:page])
  end

  private

    def set_user
      @user = User.find_by_username(params[:user_username])
      raise ActiveRecord::RecordNotFound unless @user
    end

    def tweet_params
      params.fetch(:tweet, :body).permit!
    end
end
