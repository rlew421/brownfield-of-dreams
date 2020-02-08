class GithubService

  def user_repositories
    get_json("/user/repos")
  end

  def user_followers
    get_json("/user/followers")
  end

  def user_following
    get_json("/user/following")
  end

  private

  def get_json(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    return @connection if @connection
    @connection = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
