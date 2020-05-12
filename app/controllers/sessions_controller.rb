class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    gh_info = request.env['omniauth.auth']
    current_user.update_attribute(:github_token, gh_info[:credentials][:token])
    current_user.update_attribute(:uid, gh_info[:uid])
    current_user.update_attribute(:username, gh_info['info']['nickname'])
    current_user.update_attribute(:provider, gh_info['provider'])
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
