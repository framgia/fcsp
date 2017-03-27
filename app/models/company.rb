class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :benefits, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :user, through: :employees
  has_many :teams, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :images, as: :imageable
  has_many :users, through: :employees
  has_many :company_industries
  has_many :industries, through: :company_industries
  has_many :team_introductions, as: :team_target

  ATTRIBUTES = [:name, :website, :introduction, :founder, :country,
    :company_size, :founder_on, addresses_attributes: [:id, :address,
    :longtitude, :latitude, :head_office], industries_attributes: [:id, :name]]
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :industries

  validates :name, presence: true,
    length: {maximum: Settings.company.max_length_name}
  validates :website, presence: true
  validates :company_size, numericality: {greater_than: 0}
end
