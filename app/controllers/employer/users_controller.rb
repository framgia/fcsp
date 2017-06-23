class Employer::UsersController < Employer::BaseController
  def index
    user_paginate = Supports::UserTeam.new @company, params
    @users = user_paginate.paginate
    if request.xhr?
      render json: {
        html_job: render_to_string(partial: "paginate_users",
          layout: false),
        pagination_job: render_to_string(partial: "paginate", layout: false)
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end
end
