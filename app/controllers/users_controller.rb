class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit]
  def show
    @job_active = Job.active.includes :images, :skills, :job_skills
    @job_skill = ArrayJob.get_job @job_active, @user
    @user_object = Supports::ShowUser.new @user, params[:page]
  end

  def edit
    @user.build_info_user if @user.info_user.nil?
    @info_user = @user.info_user
  end

  private

  def find_user
    @user = User.find_by id: params[:id]
    if @user
      if @user.education_status_blocked?
        flash[:danger] = t ".blocked"
        redirect_to root_url
      end
    else
      flash[:danger] = t ".not_found"
      redirect_to root_url
    end
  end
end
