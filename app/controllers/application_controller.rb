class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    before_action :login_required

    private

    def login_required
        redirect_to login_path unless current_user
    end

    def logged?
        redirect_to root_path unless !current_user
    end

    
end
