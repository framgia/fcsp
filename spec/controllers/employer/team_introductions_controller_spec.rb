require "rails_helper"

RSpec.describe Employer::TeamIntroductionsController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let!(:team_introduction){FactoryGirl.create :team_introduction}

  before :each do
    allow(controller).to receive(:current_user).and_return admin
    sign_in admin
    request.env["HTTP_REFERER"] = "sample_path"
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new, params: {company_id: company.id}
      expect(response).to render_template :new
    end

    it "has 2 image uploaders per form" do
      count = 0
      Settings.employer.controller.team_introductions
        .images.number_images.times do
          team_introduction.images.build
          count+=1
      end
      expect(count).to eq 2
    end
  end

  describe "POST #create team introductions" do
    it "create successfully" do
      team_introduction_params = FactoryGirl.attributes_for :team_introduction
      expect do
        post :create,
          params: {company_id: company.id, team_introduction: team_introduction_params},
          format: :js
      end.to change(TeamIntroduction, :count).by 1
    end

    it "create fail with status code 422" do
      team_introduction_params = FactoryGirl.attributes_for :team_introduction, title: nil, content: nil
      post :create,
        params: {company_id: company.id, team_introduction: team_introduction_params},
        format: :js
      expect(response).to have_http_status 422
    end
  end
end