class InfoUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_info_user, only: %i(index update)
  before_action :check_valid_param_type, only: :update

  def update
    if @info_user.update_attributes info_user_params
      html = render_to_string partial: "users/show_info_basic", locals: {info_user: @info_user}
      render json: {html: html, info_status: "success"}
    else
      render json: {message: @info_user.errors.full_messages}
    end
  end

  private

  def info_user_params
    params.require(:info_user).permit :relationship_status, :introduction,
      :quote, :phone, :address, :gender, :occupation, :birthday
  end

  def check_valid_param_type
    updatable_attributes = %w(relationship_status introduction quote
      phone address gender occupation birthday)

    return if updatable_attributes.include? info_user_params.keys.first
    render json: {message: t("params_error")}
  end

  def find_info_user
    @info_user = current_user.info_user
    return if @info_user
    flash[:danger] = t ".info_user_not_found"
    redirect_to root_url
  end
end
