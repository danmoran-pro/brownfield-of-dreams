class InviteController < ApplicationController
  def new; end

  def create
    github = GithubService.new(current_user.github_token)
    in_username = params['invite']['github']
    invite_email = github.grab_email(in_username)
    if invite_email.nil?
      flash[:error] = "This Github user doesn't have an email address."
    else
      send_email(in_username, invite_email)
    end
    redirect_to dashboard_path
  end

  private

  def send_email(in_username, invite_email)
    email_info = { user: current_user[:username],
                   email: invite_email,
                   in_username: in_username }
    InvitationMailer.send_invite(email_info).deliver_now
    flash[:error] = 'Successfully sent invite!'
  end
end
