class InfoUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_info_user, only: %i(index update)

  def index
    if @info_user.is_public?
      change_permission_info false
      flash[:success] = t ".profile_private"
    else
      change_permission_info true
      flash[:success] = t ".profile_public"
    end
    redirect_to current_user
  end

  def update
    if @info_user.update_attributes "#{params[:type]}": params[:input_info_user]
      info_user_attribute = InfoUser.pluck_params_type params[:id], params[:type]
      render json: {html: render_to_string(partial: "users/type",
        locals: {info_user: info_user_attribute}, layout: false), info_status: "success"}
    else
      render json: {message: @info_user.errors.full_messages}
    end
  end

  private

  def info_user_params
    params.require(:info_user).permit :introduction, :ambition, :quote, :address,
      :phone, :relationship_status, :gender, :birthday, :occupation, :country
  end

  def find_info_user
    @info_user = current_user.info_user
    return if @info_user
    flash[:danger] = t ".infor_user_not_found"
    redirect_to root_url
  end

  def change_permission_info is_public
    unless @info_user.update_attributes is_public: is_public
      flash[:danger] = t ".update_fail"
      redirect_to root_url
    end
  end

  def update_info_status info_user
    params[:info_statuses].each do |info, status|
      if InfoUser::INFO_ATTRIBUTES.include?(info.to_sym) &&
        InfoUser::INFO_STATUS.values.include?(status.to_i)
        info_user.info_statuses[info.to_sym] = status.to_i
        info_user.save
      else
        return false
      end
    end
  end
end
