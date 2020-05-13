class GithubService
  attr_reader :github_token

  def initialize(github_token)
    @github_token = github_token
  end

  def conn
    Faraday.new('https://api.github.com/user/') do |req|
      req.headers['Authorization'] = "token #{@github_token}"
      req.adapter Faraday.default_adapter
    end
  end

  def invite_conn
    Faraday.new('https://api.github.com/users/') do |req|
      req.headers['Authorization'] = "token #{@github_token}"
      req.adapter Faraday.default_adapter
    end
  end

  def grab_repos
    repos = conn.get('repos?page=1&per_page=5')
    json = JSON.parse(repos.body, symbolize_names: true)
    @user_repos = []
    json.each do |repo|
      @user_repos << Repo.new(repo[:name], repo[:html_url])
    end
    @user_repos
  end

  def grab_followers
    followers = conn.get('followers')
    json = JSON.parse(followers.body, symbolize_names: true)
    @user_followers = []
    json.each do |person|
      @user_followers << GithubUser.new(person[:login], person[:html_url])
    end
    @user_followers
  end

  def grab_following
    following = conn.get('following')
    json = JSON.parse(following.body, symbolize_names: true)
    user_following = []
    json.each do |person|
      user_following << GithubUser.new(person[:login], person[:html_url])
    end
    user_following
  end

  def grab_email(username)
    username = invite_conn.get(username)
    json = JSON.parse(username.body, symbolize_names: true)
    json[:email]
  end
end
