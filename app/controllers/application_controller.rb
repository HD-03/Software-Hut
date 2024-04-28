class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Disabling caching will prevent sensitive information being stored in the
  # browser cache. If your app does not deal with sensitive information then it
  # may be worth enabling caching for performance.
  before_action :update_headers_to_disable_caching
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  #redirects user to their specific dashboard when they login successfully
  def after_sign_in_path_for(current_user)
    case current_user.role
    when 'student'
      students_path
    when 'teacher'
      teachers_path
    when 'admin'
      admin_dashboard_path
    else
      root_path
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :name])
    end

  private
    def update_headers_to_disable_caching
      response.headers['Cache-Control'] = 'no-cache, no-cache="set-cookie", no-store, private, proxy-revalidate'
      response.headers['Pragma'] = 'no-cache'
      response.headers['Expires'] = '-1'
    end

    # def after_sign_in_path_for(resource)
    #   if resource.is_a?(User) && resource.teacher?
    #     teachers_dashboard_path
    #   else
    #     students_dashboard_path # Or some other path you want
    #   end
    # end

end
