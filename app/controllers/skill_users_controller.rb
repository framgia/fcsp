class SkillUsersController < ApplicationController
  before_action :load_user_presenter, only: %i(update destroy)

  def update
    load_skill_user params[:id]

    if @skill_user.skill.update_attributes skill_params
      if @skill_user.skill.soft_skill?
        render json: {
          status: :success,
          html: @user_presenter.load_soft_skills_html
        }
      else
        render json: {
          status: :success,
          html: @user_presenter.load_hard_skills_html
      }
      end
    else
      render json: {
        status: t("error")
      }
    end
  end

  def destroy
    load_skill_user params[:id]

    if @skill_user.skill.soft_skill?
      if @skill_user.skill.destroy
        render json: {
          status: :success,
          html: @user_presenter.load_soft_skills_html
        }
      else
        render_error
      end
    else
      if @skill_user.destroy
        render json: {
          status: :success,
          html: @user_presenter.load_hard_skills_html
        }
      else
        render_error
      end
    end
  end

  private

  def load_skill_user id
    @skill_user = SkillUser.find_by id: id

    return if @skill_user

    render json: {
      status: t("error")
    }
  end

  def skill_params
    params.require(:skill_users).permit :name, skill_users_attributes: [:id, :years, :description]
  end

  def render_error
    render json: {status: t(".destroy_skill_error")}
  end

  def load_user_presenter
    @user_presenter = UserPresenter.new current_user
  end
end
