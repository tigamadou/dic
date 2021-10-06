module SessionsHelper
    def current_user
        @current_user ||= User.includes(:tasks).find_by(id: session[:user_id])
      end
    
      def logged_in?
        current_user.present?
      end
end
