class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: %i[ edit update destroy ]
  before_action :logged?, only: [:create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if(@user == current_user)
      redirect_to mypage_path
    else
      redirect_to root_path
    end
  end

  def mypage
    @user = current_user
  end
  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    
    
      if @user.save
        session[:user_id] = @user.id
        flash[:info] = 'Connected'
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity 
      end
    
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
