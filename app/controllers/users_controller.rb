class UsersController < ApplicationController
  def show
    if !current_user.github_token.nil?
      github = GithubService.new(current_user.github_token)
      @user_repos = github.grab_repos
      @user_followers = github.grab_followers
      @user_following = github.grab_following
    end
    @organized_bookmarks = organize_bookmarks
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

  def organize_bookmarks
    organized = {}
    current_user.user_videos.each do |user_vid|
      vid = Video.find(user_vid[:video_id])
      if organized.key?(vid.tutorial)
        organized[vid.tutorial] << vid
      else
        organized[vid.tutorial] = [vid]
      end
    end
    organized
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
