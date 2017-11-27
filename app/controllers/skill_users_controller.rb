class SkillUsersController < ApplicationController
  def update
    load_skill_user skill_user_params[:id]
    if @skill_user.update_attributes years: skill_user_params[:years]
      load_skill_users
    else
      render json: {status: t(".update_skill_error")}
    end
  end

  def destroy
    load_skill_user params[:id]
    if @skill_user.destroy
      load_skill_users
    else
      render json: {status: t(".destroy_skill_error")}
    end
  end

  private

  def load_skill_users
    @skills = current_user.skill_users.includes(:skill).order_by_ASC
    render json: {
      status: :success,
      html: render_to_string(partial: "setting/profiles/skill", layout: false)
    }
  end

  def load_skill_user id
    @skill_user = current_user.skill_users.find_by id: id
    return if @skill_user
    redirect_to root_url
  end

  def skill_user_params
    params.require(:skill_users).permit :id, :years
  end
end
