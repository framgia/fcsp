require "rails_helper"

RSpec.describe SkillUser, type: :model do
  describe "Skill User validation" do
    context "association" do
      it{expect belong_to(:user)}
      it{expect belong_to(:skill)}
    end

    context "validations" do
      it{is_expected.to validate_presence_of :level}
    end

    context "column_specifications" do
      it{expect have_db_column(:skill_id).of_type(:integer)}
      it{expect have_db_column(:user_id).of_type(:integer)}
      it{expect have_db_column(:level).of_type(:integer)}
    end
  end
end
