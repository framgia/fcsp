require "rails_helper"

RSpec.describe CandidatesController, type: :controller do
  let!(:candidate){FactoryGirl.create :candidate}
  let(:user){FactoryGirl.create :user, role: 0}
  let!(:job){FactoryGirl.create :job}

  describe "POST #create candidate" do
    it "create successfully" do
      candidate_params = FactoryGirl.attributes_for :candidate
      expect do
        post :create, params:
          {candidate: candidate_params}
      end.to change(Candidate, :count).by 1
    end

    it "create unsuccessfully without user_id" do
      candidate_params = FactoryGirl.attributes_for(:candidate, user_id: nil)
      expect do
        post :create, params:
          {candidate: candidate_params}
      end.to change(Candidate, :count).by 0
      expect(flash[:danger]).to be_present
    end

    it "create unsuccessfully without job_id" do
      candidate_params = FactoryGirl.attributes_for(:candidate, job_id: nil)
      expect do
        post :create, params:
        {candidate: candidate_params}
      end.to change(Candidate, :count).by 0
      expect(flash[:danger]).to be_present
    end
  end

  describe "DELETE #destroy candidate" do
    context "deletes the candidate successfully" do
      before{delete :destroy, params: {id: candidate}}
      it{expect{response.to change(Candidate, :count).by -1}}
    end
  end
end
