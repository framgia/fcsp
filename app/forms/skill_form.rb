class SkillForm
  include ActiveModel::Validations

  validates :user, presence: true

  def initialize params, user
    @params = params
    @user = user
  end

  def save
    if @params[:skill_type] == "soft_skill"
      skill = Skill.find_by name: @params[:name]

      if skill
        skill_user = SkillUser.load_skill_user skill, @user

        return false if skill_user
      end
    end

    @skill = Skill.find_or_initialize_by name: @params[:name]
    @skill.update_attributes skill_params
  end

  def content
    user_presenter = UserPresenter.new @user
    {
      status: :success,
      html: user_presenter.skill_html_content(@skill)
    }
  end

  private

  def skill_params
    @params[:skill_users_attributes] = @params[:skill_users_attributes].each{|_, value| value[:user_id] = @user.id}
    @params
  end
end
