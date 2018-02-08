class UserPresenter
  def initialize user
    @user = user
    @skills = @user.skills
    @schools = @user.schools
  end

  def soft_skills
    @skills.soft_skill
  end

  def hard_skills
    @skills.hard_skill
  end

  def skill_user skill
    SkillUser.load_skill_user skill, @user
  end

  def load_user_schools
    UserSchool.includes(:school).by_schools @schools.ids
  end

  def skill_html_content skill
    ApplicationController.render partial: "users/#{skill.skill_type}",
      locals: {"#{skill.skill_type}": skill}, assigns: {user_presenter: UserPresenter.new(@user)}
  end

  def new_experience
    @user.work_experiences.build
  end

  def load_experiences
    @user.work_experiences.order_by_created_at
  end
end
