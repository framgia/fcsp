require "rails_helper"

RSpec.describe TeamUser, type: :model do
  describe "Team validation" do
    context "association" do
      it{expect belong_to(:team)}
      it{expect belong_to(:user)}
    end

    context "column_specifications" do
      it{expect have_db_column(:user_id).of_type(:integer)}
      it{expect have_db_column(:team_id).of_type(:integer)}
    end
  end
end
