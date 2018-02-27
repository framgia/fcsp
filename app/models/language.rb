class Language < ApplicationRecord
  has_many :user_languages
  has_many :users, through: :user_languages
  validates :name, presence: true, length: {
    maximum: Settings.language.name_max_length
  }
  accepts_nested_attributes_for :user_languages
end
