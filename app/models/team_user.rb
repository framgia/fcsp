class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user
  after_create :send_email

  private

  def send_email
    SendEmailJob.set(wait: Settings.employer.delay_send_mail.seconds)
      .perform_later self.user_id, self.team_id
  end
end
