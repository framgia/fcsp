class Group < ApplicationRecord
  belongs_to :company
  has_many :permissions
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
end
