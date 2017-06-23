module Supports
  class UserTeam
    attr_reader :company, :params

    def initialize company, params
      @company = company
      @params = params
    end

    def paginate
      @users = @company.employees.includes(user: [:avatar]).page(params[:page])
        .per Settings.employer.jobs.per_page
    end
  end
end
