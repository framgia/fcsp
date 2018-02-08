class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :authenticate_tms
  before_action :is_employer?, only: %i(show follow unfollow)
  load_and_authorize_resource
  skip_authorization_check only: :show
  before_action :check_valid_param_type, only: :update

  autocomplete :skill, :name, full: true
  autocomplete :school, :name

  def show
    user_shares = @user.user_shares.includes :avatar
    user_following = @user.following_users.includes :avatar
    @users = {user_shares: user_shares,
      limit_user_shares: user_shares.take(Settings.user.limit_user),
      user_following: user_following,
      limit_user_following: user_following.take(Settings.user.limit_user)}
    @advance_profiles = {schools: @user.schools,
      skills: @user.skill_users.includes(:skill),
      languages: @user.user_languages.includes(:language),
      courses: @user.courses.includes(:programming_language)}
  end

  def edit
    @info_user = current_user.info_user
    @skill = Skill.new
    @image = Image.new
    @user_presenter = UserPresenter.new current_user
    @school = School.new
  end

  def update
    if current_user.update_attributes user_params
      type_update = user_params.keys.first
      value_update = user_params[type_update]

      render json: {html: value_update, info_status: "success", type: type_update}
    else
      render json: {message: current_user.errors.full_messages}
    end
  end

  def update_auto_synchronize
    if current_user.update_attributes auto_synchronize: params[:auto_synchronize]
      flash[:success] = t "users.update.auto_synchronize_success"
    else
      flash[:error] = t "users.update.auto_synchronize_error"
    end
    redirect_to setting_root_path
  end

  def follow
    @object.follow @user
    render json: {
      html: render_to_string(partial: "follow_user", layout: false, locals: {user: @user})
    }
  end

  def unfollow
    @object.stop_following @user
    render json: {
      html: render_to_string(partial: "follow_user", layout: false, locals: {user: @user})
    }
  end

  private

  def user_params
    params.require(:user).permit :name
  end

  def is_employer?
    if user_signed_in? && current_user.employer? && current_user.company_id
      @object = Company.find_by id: current_user.company_id
    else
      @object = current_user
    end
  end

  def check_valid_param_type
    updatable_attributes = %w(name)

    return if updatable_attributes.include? user_params.keys.first
    render json: {message: t("params_error")}
  end
end
