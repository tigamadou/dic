class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :admin_role_required
  before_action :can_delete_admin?, only: %i[ destroy]
  before_action :can_edit_admin?, only: %i[ update ]
  def index
    @users = User.all.includes(:tasks)
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
        
        format.html do
          
          flash.now[:primary] = 'Connected!'
          redirect_to admin_users_path
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.skip_validations = true
    respond_to do |format|
      if @user.update(admin_user_params)
        format.html { redirect_to admin_user_path @user, notice: "User was successfully updated." }
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

    def admin_role_required
      if !admin? 
        flash.keep[:danger] = 'Area access restricted to Administrator.!'
        redirect_to root_path 
      end
    end
    def can_delete_admin?
      if is_last_admin?
        flash.keep[:danger] = 'This user is the last Administrator.!'
        redirect_to admin_users_path 
      end
    end

    def can_edit_admin?
      if is_last_admin? && admin_user_params[:role] != 'admin'
        flash.keep[:danger] = 'This user is the last Administrator.!'
        redirect_to admin_users_path 
      end
    end

    def is_last_admin?
      return true if User.get_admins.count == 1 && @user.role == 'admin'
    end
end
