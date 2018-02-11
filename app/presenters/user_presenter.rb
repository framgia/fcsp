class UserPresenter
  def initialize user
    @user = user
    @skills = @user.skills
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

  def skill_html_content skill
    ApplicationController.render partial: "users/#{skill.skill_type}",
      locals: {"#{skill.skill_type}": skill}, assigns: {user_presenter: UserPresenter.new(@user)}
  end

  def load_soft_skills_html
    ApplicationController.render partial: "users/soft_skill",
      collection: UserPresenter.new(@user).soft_skills,
      assigns: {user_presenter: UserPresenter.new(@user)}
  end

  def load_hard_skills_html
    ApplicationController.render partial: "users/hard_skill",
      collection: user_presenter.hard_skills,
      assigns: {user_presenter: UserPresenter.new(@user)}
  end
end
