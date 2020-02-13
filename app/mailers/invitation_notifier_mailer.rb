class InvitationNotifierMailer < ApplicationMailer
  def inform(user, contact_email)
    @user = user
    mail(to: contact_email, subject: "#{@user.first_name} would like to invite you to Turing Tutorials")
  end
end
