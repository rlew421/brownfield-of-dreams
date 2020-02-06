class UsersController < ApplicationController
  def show
    user = current_user

    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
      faraday.adapter Faraday.default_adapter
    end

    response = conn.get("/user/repos")

    json = JSON.parse(response.body)
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
