require "rails_helper"

RSpec.describe Education::Post, type: :model do
  let(:education_post){FactoryGirl.create :education_post}
  let(:user){FactoryGirl.create :user}
  let(:education_category){FactoryGirl.create :education_category}

  describe "associations" do
    it{is_expected.to belong_to :user}
    it{is_expected.to belong_to :category}
  end

  describe "columns" do
    it{expect(education_post).to have_db_column(:title).of_type(:string)}
    it{expect(education_post).to have_db_column(:content).of_type(:text)}
    it{expect(education_post).to have_db_column(:user_id).of_type(:integer)}
    it do
      expect(education_post).to have_db_column(:category_id)
        .of_type(:integer)
    end
  end

  describe "validation" do
    context "title" do
      it{is_expected.to validate_presence_of(:title)}
      it do
        is_expected.to validate_length_of(:title)
          .is_at_most Settings.education.post.title_max_length
      end
      it do
        is_expected.to validate_length_of(:title)
          .is_at_least Settings.education.post.title_min_length
      end
    end

    context "content" do
      it{is_expected.to validate_presence_of(:content)}
      it do
        is_expected.to validate_length_of(:title)
          .is_at_least Settings.education.post.title_min_length
      end
    end

    context "user" do
      it{is_expected.to validate_presence_of(:user_id)}
    end

    context "category" do
      it{is_expected.to validate_presence_of(:category_id)}
    end
  end

  describe "scope" do
    context "by_keywords" do
      let(:education_post_with_title) do
        FactoryGirl.create :education_post_with_title
      end

      let(:education_post_with_content) do
        FactoryGirl.create :education_post_with_content
      end

      it do
        expect(Education::Post.ransack("Curabitur").result)
          .to include education_post_with_title
      end
      it do
        expect(Education::Post.ransack("tellus").result)
          .to include education_post_with_content
      end
    end

    context "by_user_id" do
      it do
        expect(Education::Post.by_user_id user.id).to include education_post
      end
    end

    context "by_category_id" do
      it do
        expect(Education::Post.by_category_id education_category.id)
          .to include education_post
      end
    end
  end
end
