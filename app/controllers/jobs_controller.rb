class JobsController < ApplicationController
  load_and_authorize_resource
  before_action :load_candidate, only: :show

  def index
    @jobs = Job.community.newest.includes(:images).page(params[:page])
      .per Settings.jobs.per_page
  end

  def show
    @job_object = Supports::ShowJob.new @job
    @candidate ||= @job.candidates.build
  end

  private
  def load_candidate
    @candidate = Candidate.find_by user_id: current_user.id, job_id: @job.id
  end
end
