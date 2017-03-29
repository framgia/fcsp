class Employer::CandidatesController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_company, :load_candidates, only: :index

  def index
    @index = 0
    respond_to do |format|
      if request.xhr?
        format.html do
          render partial: "candidate_by_select_job",
          locals: {candidates: @candidates}
        end
      else
        format.html
      end
    end
  end

  private

  def load_candidates
    if params[:job_id].blank?
      @jobs = @company.jobs
      @candidates = @jobs.map(&:candidates)
    else
      @job = Job.find_by id: params[:job_id]
      @candidates = @job.candidates
    end
  end

  def load_company
    @company = Company.find_by id: params[:company_id]
  end
end
