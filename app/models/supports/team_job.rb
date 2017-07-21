module Supports
  class TeamJob
    attr_reader :company, :params

    def initialize company, params
      @company = company
      @params = params
    end

    def paginate
      if params[:type]
        sort_by = params[:sort].present? ? params[:sort] : "ASC"
        @teams = @company.teams.includes(:images)
          .filter(params[:array_id], sort_by, params[:type])
          .page(params[:page]).per Settings.employer.team.per_page
      else
        @teams = @company.teams.includes(:images).page(params[:page])
          .per Settings.employer.team.per_page
      end
    end
  end
end
