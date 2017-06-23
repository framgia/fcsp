class Employer::TeamsController < Employer::BaseController
  before_action :load_company, only: [:index, :new, :create]
  before_action :load_team, except: [:index, :new, :create]

  def index
    team_paginate = Supports::TeamJob.new @company, params
    @teams = team_paginate.paginate
    if request.xhr?
      @job = Job.find_by id: params[:id]
      unless @job
        flash[:danger] = t ".not_found"
        redirect_to employer_company_teams_path
      end
      render json: {
        html_job: render_to_string(partial:
          params[:paginate_team] ? "paginate_team_for_job" : @teams, locals:
          {company: @company}, layout: false),
        pagination_job: render_to_string(partial: "paginate", locals:
          {teams: @teams}, layout: false)
      }
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def new
    @team = @company.teams.build
    @team.images.build
    @users = @company.employees.includes(user: [:avatar])
      .page(Settings.employer.jobs.page)
      .per Settings.employer.jobs.per_page
    @team.team_introductions.build
  end

  def create
    @team = @company.teams.build team_params
    if @team.save
      flash[:success] = t ".create_success"
      redirect_to employer_company_teams_url
    else
      flash[:danger] = t ".create_fail"
      redirect_to new_employer_company_team_url
    end
  end

  def edit
  end

  def show
  end

  def update
    if @team.update_attributes team_params
      flash[:success] = t ".update_success"
      render :index
    else
      flash[:danger] = t ".update_fail"
      redirect_back fallback_location: :back
    end
  end

  def destroy
    @team.destroy
    redirect_to employer_company_teams_url
  end

  private

  def team_params
    params.require(:team).permit Team::ATTRIBUTES
  end

  def load_company
    return if @company = Company.find_by(id: params[:company_id])
    flash[:danger] = t ".not_found"
    redirect_to employer_company_teams_path
  end

  def load_team
    return if @team = Team.find_by(id: params[:id])
    flash[:danger] = t ".not_found"
    redirect_to employer_company_teams_path
  end
end
