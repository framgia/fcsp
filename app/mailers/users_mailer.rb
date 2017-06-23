class UsersMailer < ApplicationMailer
  def invite_member_team user_id, team_id
    user = User.find_by id: user_id
    @team_user = user.team_users.find_by id: team_id
    mail to: user.email, subject: "Email"
  end
end
