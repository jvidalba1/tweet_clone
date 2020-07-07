class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:feed]

  def feed
    @tweets = TweetsQuery.new(current_user).all.paginate(page: params[:page])
  end

  def home
  end
end
