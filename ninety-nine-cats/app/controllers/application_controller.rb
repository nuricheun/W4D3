class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    # helper_method :owns_current_cat


    # def current_cat_rental_request
    #     @rental_request ||=
    #     CatRentalRequest.includes(:cat).find(params[:id])
    # end

    # def current_cat
    #     current_cat_rental_request.cat
    # end

    # def owns_current_cat
    #     !!(current_user.cats.find_by(id: current_cat.id))
    # end

    def current_user 
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!(current_user)
    end

    def login_user! 
        session[:session_token] = @user.reset_session_token!
    end

    def require_log_out
        redirect_to cats_url if logged_in?
    end
    def require_log_in
        redirect_to cats_url unless logged_in?
    end
end
