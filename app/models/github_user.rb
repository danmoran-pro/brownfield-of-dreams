class GithubUser
  attr_reader :name, :url

  def initialize(name, url)
    @name = name
    @url = url
  end

  def account?
    User.find_by(username: @name)
  end
end
