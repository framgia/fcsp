require "rails_helper"

RSpec.describe Education::Category, type: :model do
  let(:education_category){FactoryGirl.create :education_category}

  describe "associations" do
    it{is_expected.to have_many :posts}
  end

  describe "columns" do
    it{expect(education_category).to have_db_column(:name).of_type(:string)}
  end

  describe "validation" do
    context "name" do
      it{is_expected.to validate_presence_of(:name)}
      it do
        is_expected.to validate_length_of(:name)
          .is_at_most Settings.education.category.name_max_length
      end
    end
  end
end
