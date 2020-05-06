
class UsersController < ApplicationController
  def show
    username = 'margoflewelling'
    conn(username)

    @user_repos = get_repos
    @user_followers = get_followers
    @user_following = get_following

  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def conn(username)
    @connection = Faraday.new("https://api.github.com/users/#{username}")
  end 

  def get_repos
    repos = @connection.get('repos?page=1&per_page=5')
    json = JSON.parse(repos.body, symbolize_names: true)
    @user_repos = []
    json.each do |repo|
                 @user_repos <<  Repo.new(repo[:name], repo[:html_url])
              end
    @user_repos
  end 

  def get_followers
    followers = @connection.get('followers')
    json = JSON.parse(followers.body, symbolize_names: true)
    @user_followers = []
    json.each do |follower|
                  @user_followers << Follower.new(follower[:login], follower[:html_url])
              end
    @user_followers
  end 

  def get_following
    following = @connection.get('following')
    json = JSON.parse(following.body, symbolize_names: true)
    @user_following = []
    json.each do |following|
                  @user_following << Following.new(following[:login], following[:html_url])
              end
    @user_following
  end 

  
end
