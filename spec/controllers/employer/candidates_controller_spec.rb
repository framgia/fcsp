require "rails_helper"

RSpec.describe Employer::CandidatesController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let!(:candidate){FactoryGirl.create :candidate, user_id: 1, job_id: 1}
  describe "GET #index" do
    it "populates an array of candidates" do
      job = FactoryGirl.create :job, company_id: company.id
      candidate.job_id = job.id
      candidate.save

      get :index, params: {company_id: company.id}
      expect(assigns(:candidates).first[0]).to eq([candidate][0])
    end

    it "responds successfully with an HTTP 200 status code" do
      get :index, params: {company_id: company.id}
      expect(response).to be_success
      expect(response).to have_http_status 200
    end
  end
end
