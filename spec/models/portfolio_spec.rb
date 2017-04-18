require "rails_helper"

RSpec.describe Portfolio, type: :model do
  describe "Address validation" do
    context "association" do
      it{expect belong_to(:user)}
    end

    context "validations" do
      it{is_expected.to validate_presence_of :title}
      it{is_expected.to validate_presence_of :url}
      it{is_expected.to validate_presence_of :description}
      it do
        is_expected.to validate_length_of(:title)
          .is_at_most Settings.portfolio.max_title_length
      end

      it do
        is_expected.to validate_length_of(:url)
          .is_at_most Settings.portfolio.max_url_length
      end

      it do
        is_expected.to validate_length_of(:description)
          .is_at_most Settings.portfolio.max_desciption_length
      end
    end

    context "column_specifications" do
      it{expect have_db_column(:title).of_type(:string)}
      it{expect have_db_column(:url).of_type(:float)}
      it{expect have_db_column(:description).of_type(:float)}
      it{expect have_db_column(:time).of_type(:datetime)}
    end
  end
end
