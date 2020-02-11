class Follower

  attr_reader :login, :html_url

  def initialize(attributes = {})
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def has_login?
    User.where(github_login: @login).first
  end
end
