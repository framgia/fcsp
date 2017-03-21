class Employer::TeamIntroductionsController < Employer::BaseController
  load_and_authorize_resource

  def new
    Settings.employer.controller.team_introductions.images.number_images.times {@team_introduction.images.build}
  end

  def create
    @team_target = find_team_target
    @team_introduction = @team_target.team_introductions.build team_introduction_params
    respond_to do |format|
      if @team_introduction.save
        format.html
        format.json {render json: {}}
      else
        format.html
        format.json {render json: @team_introduction.errors.full_messages,
          status: 422}
      end
    end
  end

  private
  def team_introduction_params
    params.require(:team_introduction).permit TeamIntroduction::ATTRIBUTES
  end

  def find_team_target
    params.each do |name, value|
      if name =~/(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
