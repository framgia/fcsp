module Supports
  class ShowUser
    attr_reader :user

    def initialize user
      @user = user
    end

    def count_user_projects
      user.education_projects.size
    end

    def user_projects
      user.education_projects.order(created_at: :desc)
        .limit Settings.users.show.limit_view_project
    end

    def employee_info company
      Employee.find_by user_id: @user.id, company_id: company.id
    end
  end
end
