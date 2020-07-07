class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:feed]

  def feed
    tweets
  end

  def home
  end

  private

    def tweets
      @tweets ||= Tweet.where(user: following_ids << current_user.id).order(created_at: :desc).paginate(page: params[:page])
    end

    def following_ids
      current_user.all_following.map(&:id)
    end
end
