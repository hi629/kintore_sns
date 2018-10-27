class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def after_sign_in_path_for(resource)
    root_path
  end

  private
    def logged_in?
      !current_user.nil?
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end  

    def authenticate?
      return if logged_in?
      redirect_to root_path, notice:"Please log in."
    end
end
