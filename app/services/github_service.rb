class GithubService

  def initialize(token)
    @token = token
  end

  def user_repositories
    get_json("/user/repos")
  end

  def user_followers
    get_json("/user/followers")
  end

  def user_following
    get_json("/user/following")
  end

  def user_follower_show(handle)
    get_json("/users/#{handle}")
  end

  private

  def get_json(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    return @connection if @connection
    @connection = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{@token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
