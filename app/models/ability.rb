class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    case user.role
    when "admin"
      can :manage, Company
      can :manage, User
      can :manage, Job
      can :manage, TeamIntroduction
    else
      can :read, Company
    end
  end
end
