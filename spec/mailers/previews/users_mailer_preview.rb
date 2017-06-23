# Preview all emails at http://localhost:3000/rails/mailers/users_mailer
class UsersMailerPreview < ActionMailer::Preview
  def invite_member_team_preview
    UsersMailer.invite_member_team(2, 30)
  end
end
