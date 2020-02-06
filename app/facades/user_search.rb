class UserSearch
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def repositories
    service = GithubService.new
    @repositories ||= service.user_repositories.map do |repository_data|
      Repository.new(repository_data)
    end
  end
end
