class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :rack_mini_profiler_authorize_request, :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_location
  helper_method :notice_fail_action

  include ApplicationHelper
  include PublicActivity::StoreController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:alert] = t("model_not_found", model: exception.model)
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: {message: t("params_error")}
  end

  def routing_error
    flash[:alert] = t "routing_error"
    redirect_to root_path
  end

  def notice_fail_action
    render json: {
      status: :error
    }
  end

  private

  def rack_mini_profiler_authorize_request
    environments = Rails.application.config.rack_mini_profiler_environments
    return unless Rails.env.in? environments
    Rack::MiniProfiler.authorize_request
  end

  def set_locale
    save_session_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def save_session_locale
    session[:locale] = params[:locale] if params[:locale]
  end

  def store_location
    path = ["/users/sign_in", "/users/sign_out", "/users/sign_up",
      "/users/password/edit", "/users/password", "/users/password/new",
      "/users/confirmation", "/users/confirmation/new", "/users/edit", "/users"]

    unless path.include? request.path || request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  def authenticate_tms
    if cookies.signed[:authen_service]
      @user_token = cookies.signed[:authen_service]
    else
      authen_service = Api::AuthenticateService.new(ENV["TMS_ADMIN_EMAIL"],
        ENV["TMS_ADMIN_PASSWORD"]).tms_authenticate
      if authen_service
        @user_token = authen_service["authen_token"]
        cookies.signed[:authen_service] = @user_token
      end
    end
  end

  def show_conversations
    session[:conversations] ||= []
    @conversations = Conversation.includes(:recipient, :messages)
      .find session[:conversations]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up,
      keys: [:name, :email, :password, :password_confirmation, :role,
        info_user_attributes: %i(gender birthday phone occupation)]

    devise_parameter_sanitizer.permit :account_update,
      keys: [:name, :email, :password, :password_confirmation, :role,
        :current_password, info_user_attributes: %i(gender birthday phone
        occupation relationship_status introduction quote ambition address country)]
  end

  def after_sign_in_path_for resource
    if cookies.signed[:tms_user].nil?
      authenticate_tms
      email = [current_user.email]
      cookies.signed[:tms_user] = Api::HttpActionService.new(
        Settings.api.tms_data_link, "", cookies.signed[:authen_service], email)
        .tms_user_exist?
    end
    resource
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, alert: I18n.t("devise.failure.unauthenticated")
    end
  end
end
