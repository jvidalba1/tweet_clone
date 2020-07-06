class PagesController < ApplicationController

  def home
    if current_user
      tweets
    end
  end

  def tweets
    @tweets ||= Tweet.where(user: following_ids << current_user.id).order(created_at: :desc)
  end

  def following_ids
    current_user.all_following.map(&:id)
  end
end
