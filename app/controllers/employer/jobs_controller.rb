class Employer::JobsController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_company
  before_action :load_hiring_types, only: [:new, :create, :edit]
  before_action :update_status, only: :create

  def new
    @job = Job.new
    @job.images.build
  end

  def index
    @jobs = @company.jobs.newest.page(params[:page])
      .per Settings.employer.jobs.per_page
    restore_job params[:id]
  end

  def edit
  end

  def show
    respond_to do |format|
      if request.xhr?
        format.html{render partial: "candidate_by_job", locals: {job: @job}}
      else
        format.html
      end
    end
  end

  def create
    @job = @company.jobs.build job_params
    if @job.save
      flash[:success] = t ".created_job"
      redirect_to job_path(@job)
    else
      flash[:danger] = t ".create_job_fail"
      redirect_back fallback_location: :back
    end
  end

  def update
    if @job.update_attributes job_params
      flash[:success] = t ".job_post_updated"
    else
      flash[:danger] = t ".job_post_update_fail"
    end
    redirect_to job_path(@job)
  end

  def destroy
    @job.destroy if params[:type] == "delete"
  end

  private

  def job_params
    params.require(:job).permit Job::ATTRIBUTES
  end

  def load_company
    @company = Company.find_by id: params[:company_id]
    not_found unless @company
  end

  def restore_job id
    Job.restore(id, recursive: true) if params[:type] == "reopen"
  end

  def load_hiring_types
    @hiring_types = HiringType.select :id, :name
  end

  def update_status
    if params[:preview]
      params[:status] = :preview
    else
      params[:status] = :community
    end
  end
end
