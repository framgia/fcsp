class Job < ApplicationRecord
  include Concerns::CheckPostTime
  acts_as_paranoid

  include JobShare

  after_create :send_posting_job_mail

  belongs_to :company
  belongs_to :creator, class_name: User.name, foreign_key: :user_id
  has_many :job_teams, dependent: :destroy
  has_many :teams, through: :job_teams
  has_many :images, as: :imageable, dependent: :destroy
  has_many :job_hiring_types, dependent: :destroy
  has_many :hiring_types, through: :job_hiring_types
  has_many :candidates, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :job_skills, dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :team_introductions, as: :team_target, dependent: :destroy
  has_many :shares, as: :shareable, class_name: ShareJob.name,
    dependent: :destroy
  has_many :sharers, through: :shares, source: :user

  enum status: [:active, :close, :draft]
  enum who_can_apply: [:everyone, :friends_of_members,
    :friends_of_friends_of_member]
  enum type_of_candidates: [:engineer, :creative, :director, :business_admin,
    :sales, :marketing, :medical, :others]

  accepts_nested_attributes_for :job_hiring_types,
    reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :job_teams

  delegate :name, to: :company, prefix: true
  delegate :name, to: :hiring_types, prefix: true

  ATTRIBUTES = [:title, :describe, :type_of_candidates, :who_can_apply, :status,
    :company_id, :user_id, :candidates_count, :posting_time,
    hiring_type_ids: [], team_ids: [], images_attributes:
    [:id, :imageable_id, :imageable_type, :picture, :caption]]

  TYPEOFCANDIDATES = Job.type_of_candidates
    .map{|temp,| [I18n.t(".type_of_candidates.#{temp}"), temp]}
    .sort_by{|temp| I18n.t(".type_of_candidates.#{temp}")}

  validates :title, presence: true, length: {maximum: Settings.max_length_title}
  validates :describe, presence: true
  validates :type_of_candidates, presence: true
  validates :who_can_apply, presence: true
  validates :profile_requests, presence: true
  validate :check_posting_time

  scope :newest, ->{order created_at: :desc}
  # scope :all_job, ->{}
  scope :of_ids, ->ids do
    where id: ids if ids.present?
  end

  scope :filter, ->(list_filter, sort_by, type) do
    where("#{type} IN (?)", list_filter).order "#{type} #{sort_by}"
  end

  scope :popular_job, ->{order candidates_count: :desc}

  scope :posting_job, ->job_id do
    joins(:skills, :hiring_types)
      .where("job_skills.skill_id IN (?)
      and job_hiring_types.hiring_type_id IN (?)",
        Skill.require_by_job(job_id).pluck(:id),
        HiringType.job_hiring_type(job_id).pluck(:id))
      .distinct.limit Settings.posting_job.job_limit
  end

  scope :job_posting_time, ->{where "posting_time <= ?", Time.zone.now}

  scope :delete_job, ->list_job do
    where("id IN (?)", list_job).destroy_all
  end

  def is_posted?
    posting_time < Time.zone.now
  end

  def check_posting_time
    check_time posting_time
  end

  def image_url
    images.any? ? images.first.picture_url : Settings.jobs.image_url
  end

  private

  def send_posting_job_mail
    JobMailer.posting_job(creator, self).deliver_later
  end
end
