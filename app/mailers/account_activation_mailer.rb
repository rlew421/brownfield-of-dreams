class AccountActivationMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "#{user.first_name}, please verify your Brownfield Account!")
  end
end
