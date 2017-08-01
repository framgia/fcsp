require "rails_helper"

RSpec.describe Employer::DashboardsController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}

  before :each do
    allow(controller).to receive(:current_user).and_return admin
    sign_in admin
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, params: {company_id: company.id}
      expect(response).to have_http_status 200
    end
  end
end
