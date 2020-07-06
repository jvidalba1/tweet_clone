class UsersController < ApplicationController
  before_action :set_user, only: [:show, :following, :followers]

  def show
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
