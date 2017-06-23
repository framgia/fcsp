class SendEmailJob < ApplicationJob
  queue_as :default

  def perform user_id, team_id
    UsersMailer.invite_member_team(user_id, team_id).deliver_later
  end
end
