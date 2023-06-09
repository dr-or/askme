class UsersController < ApplicationController
  before_action :set_user, only: %i[destroy edit show update]
  before_action :authorize_user, only: %i[destroy edit update]

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'you signed up successfully'
    else
      flash.now[:alert] = 'data invalid'

      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit; end

  def show
    @questions = @user.questions.includes([:author]).order(created_at: :desc)
    @question = Question.new(user: @user)
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: 'your data is updated'
    else
      flash.now[:alert] = 'data invalid'

      render :edit
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'your account was deleted'
  end

  private

  def authorize_user
    redirect_with_alert unless current_user == @user
  end

  def set_user
    @user = User.find_by!(nickname: params[:nickname])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation,
                                 :navbar_color)
  end
end
