class CoursesController < ApplicationController
  before_action :find_user, only: :show
  before_action :find_course, only: :show

  def show
    @user_object = Supports::ShowUser.new @user, current_user, params
    @course_subjects = @course.course_subjects.includes(:subject)
  end

  private

  def find_user
    @user = User.includes(:info_user).find_by id: params[:user_id]

    return if @user
    flash[:danger] = t ".user_not_found"
    redirect_to root_url
  end

  def find_course
    @course = @user.courses.find_by id: params[:id]

    return if @course
    flash[:danger] = t ".course_not_found"
    redirect_to @user
  end
end
