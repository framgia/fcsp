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
      can :read, Job
    end

    user.education_groups.each do |education_group|
      get_permission_of_group_for_authentication education_group
    end
  end

  private

  def get_permission_of_group_for_authentication education_group
    education_group.permissions.each do |permission|
      authenticate permission
    end
  end

  def authenticate permission
    permission.optional.each do |action, accessable|
      if accessable
        can action, permission.entry.constantize
      else
        cannot action, permission.entry.constantize
      end
    end
  end
end
