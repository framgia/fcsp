class SchoolsController < ApplicationController
  def create
    school = School.find_by name: params[:name]

    if school
      if school.update_attributes school_params
        load_schools
      else
        render_json_error
      end
    else
      @school = School.new school_params
      @school.user_schools.first.user_id = current_user.id

      if @school.save
        load_schools
      else
        render_json_error
      end
    end
  end

  private

  def school_params
    params.require(:school).permit :name,
      user_schools_attributes: [:school_id, :degree, :major, :graduation,
        :activity, :description]
  end

  def load_schools
    @schools = current_user.user_schools.includes :school

    render json: {
      status: :success,
      html: render_to_string(
        partial: "user_schools/user_school",
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
