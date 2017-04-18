require "rails_helper"

RSpec.describe Club, type: :model do
  describe "Address validation" do
    context "association" do
      it{expect belong_to(:user)}
    end

    context "validations" do
      it{is_expected.to validate_presence_of :name}
      it{is_expected.to validate_presence_of :description}
      it{is_expected.to validate_presence_of :image}
      it do
        is_expected.to validate_length_of(:name)
          .is_at_most Settings.club.max_name_length
      end

      it do
        is_expected.to validate_length_of(:description)
          .is_at_most Settings.club.max_description_length
      end
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:description).of_type(:string)}
      it{expect have_db_column(:image).of_type(:string)}
      it{expect have_db_column(:begin_time).of_type(:datetime)}
      it{expect have_db_column(:end_time).of_type(:datetime)}
    end
  end
end
