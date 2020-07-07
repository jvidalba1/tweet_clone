class Finder

  def initialize(finder_params, user)
    @finder_params = finder_params
    @user = user
  end

  def call
    return OpenStruct.new(success?: false, user: nil, error: "User not found.") unless finder_user
    return OpenStruct.new(success?: false, user: finder_user, error: "You're already following this user.") if @user.following?(@finder_user)

    @user.follow(@finder_user)
    OpenStruct.new(success?: true, user: finder_user, errors: nil)
  end

  private

    def finder_user
      @finder_user ||= User.find_by_username(@finder_params[:username])
    end
end
