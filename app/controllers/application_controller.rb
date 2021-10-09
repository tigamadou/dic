class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    before_action :login_required

    def admin_role_required
        if !admin? 
            flash.keep[:danger] = 'Area access restricted to Administrator.!'
            redirect_to root_path 
        end
    end

   
    private
    
    def login_required
        redirect_to login_path unless current_user
    end
    
    def logged?
        redirect_to root_path unless !current_user
    end

end
