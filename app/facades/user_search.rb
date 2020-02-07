class UserSearch
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def repositories
    GithubService.new.user_repositories.map do |repository_data|
      Repository.new(repository_data)
    end
  end

  def followers
    GithubService.new.user_followers.map do |follower_data|
      Follower.new(follower_data)
    end
  end
end
