class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:info] = 'Conected'
      redirect_to root_path
    else
      flash.now[:danger] = 'Wrong credentials.!'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:info] = 'logged out'
    redirect_to new_session_path
  end
end
