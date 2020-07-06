class PagesController < ApplicationController

  def home
    if current_user
      @tweets = current_user.tweets #missing following tweets
    end
  end
end
