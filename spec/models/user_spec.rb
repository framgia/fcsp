require "rails_helper"

RSpec.describe User, type: :model do
  describe "User validation" do
    context "association" do
      it{expect have_many(:articles)}
      it{expect have_many(:bookmarks)}
      it{expect have_many(:education_posts)}
      it{expect have_many(:education_socials)}
      it{expect have_many(:education_comments)}
      it{expect have_many(:education_rates)}
      it{expect have_many(:education_project_members)}
      it{expect have_many(:course_members)}
      it{expect have_many(:education_courses)}
      it{expect have_many(:education_projects)}
      it{expect have_many(:education_user_groups)}
      it{expect have_one(:education_program_member)}
      it{expect have_one(:education_learning_program)}
      it{expect have_one(:info_user)}
      it{expect have_many(:awards)}
    end

    context "column_specifications" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:email).of_type(:string)}
      it{expect have_db_column(:avatar).of_type(:string)}
      it{expect have_db_column(:phone).of_type(:string)}
      it{expect have_db_column(:role).of_type(:integer)}
      it{expect have_db_column(:encrypted_password).of_type(:string)}
    end
  end

  describe "validations" do
    it{expect validate_presence_of(:name)}
    it do
      expect validate_length_of(:name)
        .is_at_most Settings.company.max_length_name
    end
    it{expect validate_presence_of(:email)}
  end

  describe "scope" do
    let!(:training){FactoryGirl.create :training}
    let!(:user1){FactoryGirl.create :user}
    let!(:user2){FactoryGirl.create :user}
    let!(:user3){FactoryGirl.create :user}
    let!(:course){FactoryGirl.create :course, training_id: training.id}
    let!(:project){FactoryGirl.create(:project)}
    it "not_in_course" do
      course.course_members.create user_id: user1.id
      users = User.not_in_object(course)
      expect(users).to eq [user2, user3]
    end
    it "not_in_project" do
      project.members.create user_id: user1.id
      users = User.not_in_object(project)
      expect(users).to eq [user2, user3]
    end
  end
end
