class SessionsController < ApplicationController
  def new
  end

  def create
    session_params = params.require(:session)

    user = User.find_by(email: session_params[:email])&.authenticate(session_params[:password])

    if user.present?
      session[:user_id] = user.id

      redirect_to root_path, notice: 'you signed in'
    else
      flash.now[:alert] = 'wrong email or password'

      render :new
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path, notice: 'you signed out'
  end
end
