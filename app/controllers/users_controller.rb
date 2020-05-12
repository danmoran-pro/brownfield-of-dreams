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

  def organize_bookmarks
    organized = Hash.new
    current_user.user_videos.each do |user_vid|
      vid = Video.find(user_vid[:video_id])
      tutorial = Tutorial.find(vid[:tutorial_id])
      if organized.has_key?(tutorial)
        organized[tutorial] << vid
      else
         organized[tutorial] = [vid]
      end
    end
    organized
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
