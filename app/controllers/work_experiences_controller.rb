class WorkExperiencesController < ApplicationController
  before_action :find_work_experience, only: [:destroy, :update]

  def create
    work_experience = current_user.work_experiences.build experience_params
    work_experience.user_id = current_user.id

    if work_experience.save
      load_work_experiences
    else
      notice_fail_action
    end
  end

  def update
    if @work_experience.update_attributes experience_params
      load_work_experiences
    else
      notice_fail_action
    end
  end

  def destroy
    if @work_experience.destroy
      load_work_experiences
    else
      notice_fail_action
    end
  end

  private

  def load_work_experiences
    @user_presenter = UserPresenter.new current_user

    render json: {
      status: :success,
      html: render_to_string(partial: "experiences/current_experience", layout: false)
    }
  end

  def find_work_experience
    @work_experience = current_user.work_experiences.find_by id: params[:id]
    return if @work_experience
    redirect_to edit_user_path current_user
  end

  def experience_params
    params.require(:work_experience).permit :user_id, :organization,
      :date_from, :date_to, :position, :job_requirement
  end
end
