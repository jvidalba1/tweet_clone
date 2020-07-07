class TweetPolicy < ApplicationPolicy
  attr_reader :user, :tweet

  def initialize(user, tweet)
    @user = user
    @tweet = tweet
  end

  def new?
    tweet.user == user
  end

  def create?
    tweet.user == user
  end
end
