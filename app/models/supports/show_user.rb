module Supports
  class ShowUser
    attr_reader :user

    def initialize user, page_param
      @user = user
      @page_param = page_param
    end

    def pagination resources
      resources.page(@page_param).per Settings.resources.per_page
    end

    def skills
      pagination @user.skills.order(created_at: :desc)
    end

    def portfolios
      pagination @user.portfolios.order(created_at: :desc)
    end

    def socials
      pagination @user.socials
    end

    def clubs
      pagination @user.clubs
    end
  end
end
