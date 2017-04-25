require "rails_helper"

RSpec.describe Social, type: :model do
  describe "Social validation" do
    context "association" do
      it{is_expected.to belong_to :target}
    end

    context "validations" do
      it{is_expected.to validate_presence_of :name}
      it{is_expected.to validate_presence_of :url}
      it{is_expected.to validate_presence_of :social_type}
      it do
        is_expected.to validate_length_of(:name)
          .is_at_most Settings.social.max_name_length
      end

      it do
        is_expected.to validate_length_of(:url)
          .is_at_most Settings.social.max_url_length
      end
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:url).of_type(:string)}
      it{expect have_db_column(:social_type).of_type(:string)}
    end
  end
end
