class Employer::JobsController < Employer::BaseController
  before_action :load_hiring_types, only: [:new, :create, :edit]
  before_action :update_status, only: :create
  before_action :load_job, only: [:edit, :update]

  def index
    if params[:type]
      listarr = params[:array_id]
      listarr = listarr.split(",").map(&:to_i) if listarr.class == String
      sort_by = params[:sort].nil? ? "ASC" : params[:sort]
      @jobs = @company.jobs.includes(:candidates, :images, :bookmarks)
        .filter(listarr, sort_by, params[:type]).page(params[:page])
        .per Settings.employer.jobs.per_page
    else
      @jobs = @company.jobs.includes(:candidates, :images, :bookmarks)
        .page(params[:page]).per Settings.employer.jobs.per_page
    end
    respond_to do |format|
      format.js{
        render json: {
        html_job: render_to_string(partial: "job",
          locals: {jobs: @jobs, company: @company}, collection: @jobs),
        pagination_job: render_to_string(partial: "paginate",
          locals: {jobs: @jobs}, layout: false)
        }
      }
      format.html
    end
  end

  def new
    @job = Job.new
    @job.images.build
    @teams = @company.teams.includes(:images).page(Settings.employer.page)
      .per Settings.employer.team.per_page
  end

  def create
    @job = @company.jobs.build job_params
    @job.posting_time = Time.zone.now unless @job.posting_time

    if @job.save
      flash[:success] = t "employer.jobs.create.created"
      redirect_to @job
    else
      flash[:danger] = t "employer.jobs.create.failed"
      redirect_back fallback_location: :back
    end
  end

  def edit
    @job.images.build if @job.images.blank?
    respond_to do |format|
      format.js
    end
  end

  def update
    params[:job].delete :posting_time if @job.is_posted?
    if @job.update_attributes job_params
        @teams = @company.teams.includes(:images).page(Settings.employer.page)
          .per Settings.employer.team.per_page
        respond_to do |format|
          format.json {render json: {
            status: Job.human_enum_name(:status, @job.status)
          }}
          format.js {render "update.js.erb", locals: {job: @job}}
          format.html {redirect_to employer_company_jobs_path @company}
        end
    else
      redirect_back fallback_location: :back
    end
  end

  def destroy
    Job.delete_job params[:array_id]
    @jobs = @company.jobs.includes(:candidates, :images, :bookmarks)
      .page(params[:page]).per Settings.employer.jobs.per_page

    respond_to do |format|
      format.js{
        render json: {
        html_job: render_to_string(partial: "job",
          locals: {jobs: @jobs, company: @company}, collection: @jobs),
        pagination_job: render_to_string(partial: "paginate",
          locals: {jobs: @jobs}, layout: false)
        }
      }
      format.html
    end
  end

  private

  def job_params
    params.require(:job).permit Job::ATTRIBUTES
  end

  def load_hiring_types
    @hiring_types = HiringType.select :id, :name
  end

  def update_status
    params[:status] = params[:preview] ? :draft : :open
  end

  def load_job
    @job = Job.find_by(id: params[:id])
    @job.posting_time = Time.zone.now
    unless @job
      flash[:danger] = t ".not_found"
      redirect_to employer_company_job_path
    end
  end
end
