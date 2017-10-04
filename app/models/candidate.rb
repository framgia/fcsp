class Candidate < ApplicationRecord
  after_create :send_apply_job_mail

  belongs_to :user
  belongs_to :job, counter_cache: true

  has_one :avatar, through: :user, class_name: Image.name, dependent: :destroy

  enum interested_in: %i(have_a_chat work_together opportunity)
  enum process: %i(apply fail_test joined pass_test wait_test)

  validates :user_id, presence: true
  validates :job_id, presence: true
  validates :interested_in, presence: true
  validates :process, presence: true

  delegate :title, to: :job, prefix: true, allow_nil: true
  delegate :email, :name, to: :user, prefix: true

  scope :in_jobs, ->job_ids{where job_id: job_ids}

  scope :filter, ->(list_filter, sort_by, type) do
    where("#{type} IN (?)", list_filter).order "#{type} #{sort_by}"
  end

  scope :delete_candidate, ->list_candidate do
    where("id IN (?)", list_candidate).destroy_all
  end

  private

  def send_apply_job_mail
    JobMailer.apply_job(user, job).deliver_later
  end
end
