class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :authenticate_tms
  before_action :is_employer?, only: %i(show follow unfollow)
  load_resource only: %i(show follow unfollow)
  autocomplete :skill, :name, full: true

  def show
    @user_object = Supports::ShowUser.new @user, current_user, params
    @advance_profiles = {schools: @user.schools,
      skills: @user.skill_users.includes(:skill),
      languages: @user.user_languages.includes(:language),
      courses: @user.courses.includes(:programming_language)}

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
      format.json {
        render json: {
          status: :success,
          html: render_to_string(partial: "users/advance_profile", formats: :html,
          locals: {user: @user, advance_profiles: @advance_profiles},
            layout: false)
        }
      }
      format.js
    end
  end

  def edit
    @info_user = current_user.info_user
    @skill = Skill.new
    @skills = current_user.skill_users.includes :skill
  end

  def update
    if current_user.update_attributes "#{params[:type]}": params[:input_info_user]
      user_attribute = User.pluck_params_type params[:id], params[:type]
      render json: {html: render_to_string(partial: "setting/profiles/type",
        locals: {info_user: user_attribute}, layout: false), info_status: "success"}
    else
      render json: {message: current_user.errors.full_messages}
    end
  end

  def update_auto_synchronize
    if current_user.update_attributes auto_synchronize: params[:auto_synchronize]
      flash[:success] = t ".auto_synchronize_success"
    else
      flash[:error] = t ".auto_synchronize_error"
    end
    redirect_to setting_root_path
  end

  def follow
    @object.follow @user
    render json: {
      html: render_to_string(partial: "follow_user", layout: false, locals: {user: @user})
    }
  end

  def unfollow
    @object.stop_following @user
    render json: {
      html: render_to_string(partial: "follow_user", layout: false, locals: {user: @user})
    }
  end

  private

  def is_employer?
    if user_signed_in? && current_user.employer? && current_user.company_id
      @object = Company.find_by id: current_user.company_id
    else
      @object = current_user
    end
  end
end
