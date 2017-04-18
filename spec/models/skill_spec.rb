require "rails_helper"

RSpec.describe Skill, type: :model do
  describe "Skill validation" do
    context "association" do
      it{expect have_many(:users).through(:skill_users)}
      it{expect have_many(:jobs).through(:job_skills)}
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:description).of_type(:text)}
    end
  end
end
