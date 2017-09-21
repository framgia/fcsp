class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit]
  before_action :authenticate_tms

  def show
    @user_object = Supports::ShowUser.new @user, current_user, params
    @courses = @user.courses

    if request.xhr?
      if params[:suggest_jobs_page]
        return render json: {
          content: render_to_string(partial: "job_accordance", locals:
            {jobs: @user_object.user_jobs, job_page: :suggest_jobs_page})
        }
      end

      if params[:bookmarked_jobs_page]
        return render json: {
          content: render_to_string(partial: "job_accordance",
            locals: {jobs: @user_object.bookmarked_jobs,
            job_page: :bookmarked_jobs_page})
        }
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  private

  def find_user
    @user = User.includes(:info_user).find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
