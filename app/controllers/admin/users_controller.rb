class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(admin_user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html do
          
          flash.now[:primary] = 'Connected!'
          redirect_to root_path
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(admin_user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: "User was successfully destroyed." }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def admin_user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
