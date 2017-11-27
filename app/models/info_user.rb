class InfoUser < ApplicationRecord
  belongs_to :user

  INFO_ATTRIBUTES = %i(introduction ambition portfolio award work education
    link project certificate language skill)

  enum gender: %i(male female other)
  enum relationship_status: %i(single married complicated)

  validates :introduction, length: {maximum: Settings.info_users.max_length_introduce}
  validates :ambition, length: {maximum: Settings.info_users.max_length_ambition}
  validates :quote, length: {maximum: Settings.info_users.max_length_quote}
  #validates :phone, length: {maximum: Settings.info_users.max_length_phone},
    #presence: true
  #validates :birthday, presence: true
  #validates :occupation, presence: true
  #validates :gender, presence: true

  class << self
    def pluck_params_type id, type
      where(id: id).pluck(type).first
    end
  end
end
