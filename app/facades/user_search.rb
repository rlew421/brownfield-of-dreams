class UserSearch
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def user_token?
    user.token
  end

  def service
    GithubService.new(@user.token)
  end

  def repositories
    service.user_repositories.map do |repository_data|
      Repository.new(repository_data)
    end
  end

  def followers
    service.user_followers.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def following
    service.user_following.map do |following_data|
      Following.new(following_data)
    end
  end
end
