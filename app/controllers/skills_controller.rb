class SkillsController < ApplicationController
  def index;end

  def create
    skill_form = SkillForm.new skill_params, current_user

    if skill_form.save
      render json: {content: skill_form.content}
    else
      render json: {content: {status: "error"}}
    end
  end

  private

  def skill_params
    params.require(:skill).permit :name, :skill_type,
      skill_users_attributes: [:id, :years, :description]
  end
end
