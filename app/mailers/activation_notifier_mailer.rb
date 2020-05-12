class ActivationNotifierMailer < ApplicationMailer
  def activate(info)
    @email = info[:user][:email]
    @message = info[:message]
    @user = info[:user]
    mail(to: info[:user][:email], subject: 'Activate your account')
  end
end
