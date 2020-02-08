class GithubService

  def user_repositories
    response = conn.get("/user/repos")

    repo_search_results = JSON.parse(response.body, symbolize_names: true)
  end

  def user_followers
    response = conn.get("/user/followers")

    follower_search_results = JSON.parse(response.body, symbolize_names: true)
  end

  def user_following
    response = conn.get("/user/following")

    following_search_results = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    return @connection if @connection
    @connection = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
