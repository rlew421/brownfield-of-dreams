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

      AccountActivationMailer.inform(current_user).deliver_now
      flash[:notice] = "This account has not yet been activated. Please check your email."

      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to users_new_path
    end
  end

  def edit
    user = User.find(params[:id])
    user.toggle!(:active)
    user.save
    if user.active?
      flash[:success] = "Thank you! Your account is now activated."
    else
      flash[:success] = "Something went wrong. Please try again."
    end
    redirect_to "/dashboard"
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
