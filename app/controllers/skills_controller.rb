class SkillsController < ApplicationController
  def index;end

  def create
    skill = Skill.find_by name: skill_params[:name]
    if skill
      if skill.update_attributes skill_params
        load_skills
      else
        render json: {
          status: :error
        }
      end
    else
      skill = Skill.new skill_params
      if skill.save
        load_skills
      else
        render json: {
          status: :error
        }
      end
    end
  end

  private

  def skill_params
    params.require(:skill).permit :name,
      skill_users_attributes: [:id, :user_id, :years]
  end

  def load_skills
    @skills = current_user.skill_users.includes :skill
    render json: {
      status: :success,
      html: render_to_string(partial: "setting/profiles/skill", layout: false)
    }
  end
end
