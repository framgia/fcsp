class Portfolio < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,
    length: {maximum: Settings.portfolio.max_title_length}
  validates :url, presence: true,
    length: {maximum: Settings.portfolio.max_url_length}
  validates :description, presence: true,
    length: {maximum: Settings.portfolio.max_desciption_length}
end
