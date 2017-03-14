class CompanyForm < Reform::Form
  ATTRS = [:name, :introduction, :website, :founder, :company_size,
    :founder_on, :country]

  ATTRS.each{|attribute| property attribute}

  collection :groups, populate_if_empty: Group do
    property :name
    property :description
  end

  collection :employees, populate_if_empty: Employee do
    property :user_id
    property :company_id
  end

  validates :name, presence: true
  validates :name, presence: true, on: :group
end
