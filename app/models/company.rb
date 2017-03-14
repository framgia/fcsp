class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :benefits, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :employees
  has_many :users, through: :employees
  has_many :teams, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :images, as: :imageable
  has_many :team_introductions, as: :team_target_type
  has_many :groups, dependent: :destroy
end
