class Education::Post < ApplicationRecord
  belongs_to :category, class_name: Education::Category.name
  belongs_to :user

  validates :title, presence: true,
    length: {minimum: Settings.education.post.title_min_length,
      maximum: Settings.education.post.title_max_length}
  validates :content, presence: true,
    length: {minimum: Settings.education.post.content_min_length}

  validates :user_id, presence: true
  validates :category_id, presence: true

  scope :by_category_id, ->category_id do
    where category_id: category_id if category_id.present?
  end

  scope :by_user_id, ->user_id do
    where user_id: user_id if user_id.present?
  end
end
