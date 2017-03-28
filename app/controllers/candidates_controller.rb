class CandidatesController < ApplicationController
  load_resource

  def create
    @candidate = Candidate.new candidate_params
    respond_to do |format|
      if @candidate.save
        format.html do
          render partial: "unapply_job", local: {candidate: @candidate}
        end
      else
        format.html do
          flash[:danger] = t ".unapply_job"
        end
      end
    end
  end

  def destroy
    @candidate.destroy
    flash[:success] = t ".delete_apply"
    redirect_to jobs_path
  end

  private

  def candidate_params
    params.require(:candidate).permit :job_id, :user_id
  end
end
