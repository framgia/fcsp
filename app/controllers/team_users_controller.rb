class TeamUsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def update
    @team_user = TeamUser.find_by id: params[:id]
    if @team_user
      @team_user.update_attributes(status: 1)
      flash[:success] = t "team.success"
    else
      flash[:danger] = t "team.danger"
    end
    redirect_to root_url
  end
end
