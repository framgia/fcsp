require "rails_helper"

RSpec.describe Award, type: :model do
  describe "Award validation" do
    context "association" do
      it{expect belong_to(:user)}
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:time).of_type(:string)}
    end

    context "validations" do
      it{is_expected.to validate_presence_of :name}
      it{is_expected.to validate_presence_of :time}
      it do
        is_expected.to validate_length_of(:name)
          .is_at_most Settings.award.max_length_name
      end
    end

    describe "get list newest award" do
      let!(:award1){FactoryGirl.create :award, created_at: Time.now}
      let!(:award2){FactoryGirl.create :award, created_at: Time.now + 1.hour}
      let!(:award3){FactoryGirl.create :award, created_at: Time.now + 2.hours}
      awards = Award.newest
      it "returns ordered list" do
        expect(awards).to eq [award3, award2, award1]
      end
    end
  end
end
