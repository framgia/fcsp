class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
  belongs_to :position

  has_one :company, through: :group
end
