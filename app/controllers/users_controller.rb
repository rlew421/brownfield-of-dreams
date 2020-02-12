class UsersController < ApplicationController
  def show
    # user = current_user
    render locals: {
      search_results: UserSearch.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "This account has not yet been activated. Please check your email."

      AccountActivationNotifier.inform(current_user, params[:email]).deliver_now
      
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
