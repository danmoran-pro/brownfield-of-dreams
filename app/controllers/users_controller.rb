
class UsersController < ApplicationController
  def show
    repo = Faraday.get('https://api.github.com/users/margoflewelling/repos?page=1&per_page=5')
    json = JSON.parse(repo.body, symbolize_names: true)
    @user_repos = []
    json.each do |repo|
                reposit = Repo.new(repo[:name], repo[:html_url])
                @user_repos << reposit
              end
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


end
