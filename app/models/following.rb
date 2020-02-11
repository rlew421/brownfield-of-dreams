class Following
  attr_reader :login, :html_url, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def has_login?
    User.where(github_login: @login).first
  end
end
