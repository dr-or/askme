class UsersController < ApplicationController
  def create
    user_params = params.require(:user).permit(:name, :nickname, :email, :password)

    @user = User.create(user_params)

    redirect_to root_path, notice: 'you signed up successfully'
  end

  def new
    @user = User.new
  end
end
