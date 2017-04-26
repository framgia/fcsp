class Award < ApplicationRecord
  belongs_to :user

  validates :name, presence: true,
    length: {maximum: Settings.award.max_length_name}
  validates :time, presence: true

  scope :newest, ->{order created_at: :desc}
end
