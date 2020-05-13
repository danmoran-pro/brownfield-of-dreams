class InvitationMailer < ApplicationMailer
  def send_invite(info)
    @email = info[:email]
    @user = info[:user]
    @in_user = info[:in_username]
    mail(to: @email, subject: 'Invitation to Join Brownfield')
  end
end
