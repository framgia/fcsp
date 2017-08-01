require "rails_helper"

RSpec.describe PagesController, type: :controller do
  let!(:job){FactoryGirl.create :job}
  describe "GET #index" do
    it "populates an array of jobs" do
      get :index
      expect(assigns :jobs).to include job
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status 200
    end
  end
end
