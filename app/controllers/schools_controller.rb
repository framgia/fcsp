class SchoolsController < ApplicationController
  def create
    school = School.find_by name: params[:school][:name]
    byebug

    if school
      if school.update_attributes school_params
        load_schools school.user_schools.first
      else
        render_json_error
      end
    else
      @school = School.new school_params
      @school.user_schools.first.user_id = current_user.id

      if @school.save
        load_schools @school.user_schools.first
      else
        render_json_error
      end
    end
  end

  private

  def school_params
    params.require(:school).permit :name,
      user_schools_attributes: [:school_id, :degree, :major, :graduation,
        :activity, :description, :address]
  end

  def load_schools school
    render json: {
      status: :success,
      html: render_to_string(
        partial: "user_schools/user_school",
        locals: {user_school: school},
        layout: false
      )
    }
  end

  def render_json_error
    render json: {
      status: :error
    }
  end
end
