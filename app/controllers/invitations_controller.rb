class InvitationsController < ApplicationController
  def new; end

  def create
    handle = params[:github_handle]
    token = current_user.token
    service = GithubService.new(token)
    parsed = service.user_follower_show(handle)
    email = parsed[:email]

    if !email.nil?
      InvitationNotifierMailer.inform(current_user, email).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
