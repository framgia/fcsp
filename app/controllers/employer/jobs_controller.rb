class Employer::JobsController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_hiring_types, only: [:new, :create, :edit]
  before_action :update_status, only: :create

  def index
    params[:select] = "all_job" if params[:select].nil?
    @jobs = @company.jobs.includes(:candidates, :images, :bookmarks)
      .send(params[:select]).newest
      .page(params[:page]).per Settings.employer.jobs.per_page

    respond_to do |format|
      if request.xhr?
        format.html{render partial: "job", locals: {jobs: @jobs}}
      else
        format.html
      end
    end
  end

  def new
    @job = Job.new
    @job.images.build
  end

  def create
    @job = @company.jobs.build job_params
    if @job.save
      @team = @job.team_introductions.build
      @team.images.build
      flash.now[:success] = t ".created_job"
      render json: {
        html_job: render_to_string(partial: "new_job",
          layout: false)
      }, status: :created
    else
      flash[:danger] = t ".create_job_fail"
      redirect_back fallback_location: :back
    end
  end

  def edit
  end

  def update
    if @job.update_attributes job_params
      flash[:success] = t ".job_post_updated"
      if request.xhr?
        render json: {
          html_job: render_to_string(partial: "new_job",
            layout: false)
        }
      else
        redirect_to job_path(@job)
      end
    else
      flash[:danger] = t ".job_post_update_fail"
      redirect_back fallback_location: :back
    end
  end

  def destroy
    @job.destroy if params[:type] == "delete"
  end

  private

  def job_params
    params.require(:job).permit Job::ATTRIBUTES
  end

  def restore_job id
    Job.restore(id, recursive: true) if params[:type] == "reopen"
  end

  def load_hiring_types
    @hiring_types = HiringType.select :id, :name
  end

  def update_status
    params[:status] = params[:preview] ? :draft : :open
  end
end
