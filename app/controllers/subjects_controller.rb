class SubjectsController < ApplicationController
  before_action :find_user, :find_course, :find_subject, only: :show

  def show
    @user_object = Supports::ShowUser.new @user, current_user, params
    @user_tasks = @user.user_tasks.includes(:task)
      .check_course_subject params[:course_id], params[:id]
  end

  private

  def find_user
    @user = User.includes(:info_user).find_by id: params[:user_id]

    return if @user
    flash[:danger] = t ".user_not_found"
    redirect_to root_url
  end

  def find_course
    @course = @user.courses.find_by id: params[:course_id]

    return if @course
    flash[:danger] = t ".course_not_found"
    redirect_to root_url
  end

  def find_subject
    @user_course_subject = @user.user_course_subjects
      .find_by subject_id: params[:id]

    return if @user_course_subject
    flash[:danger] = t ".subject_not_found"
    redirect_to @user
  end
end
