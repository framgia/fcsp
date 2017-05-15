class TeamJobsController < ApplicationController

  def create
    @job = Job.find_by id: params[:id]
    @team = @job.team_introductions.build team_params
    if @team.save
      flash.now[:success] = t "team_jobs.create_team"
      render json: {
        html_team: render_to_string(partial: "new_team",
          layout: false)
      }, status: :created
    else
      flash[:danger] = t "team_jobs.fail_create"
      redirect_back fallback_location: :back
    end
  end

  private

  def team_params
    params.require(:team_introduction).permit TeamIntroduction::ATTRIBUTES
  end
end
