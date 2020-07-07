class TweetsQuery

  def initialize(user, relation = Tweet.includes(:user))
    @relation = relation
    @user = user
  end

  def all
    @relation.where(user: ids).order(created_at: :desc)
  end

  private

    def ids
      following_ids << user_id
    end

    def following_ids
      @user.all_following.map(&:id)
    end

    def user_id
      @user.id
    end
end
