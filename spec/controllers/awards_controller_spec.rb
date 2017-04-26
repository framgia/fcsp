require "rails_helper"

RSpec.describe AwardsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  let!(:award){FactoryGirl.create :award, user: user}
  let!(:another_user){FactoryGirl.create :user}

  before :each do
    allow(controller).to receive(:current_user).and_return(user)
    sign_in user
  end

  describe "POST #create" do
    it "create award successfully" do
      expect do
        post :create, params: {user_id: user.id,
          award: {time: "2017", name: "award 001"}}, xhr: true
      end
        .to change(Award, :count).by 1
    end

    it "create award with unvalid params" do
      expect do
        post :create, params: {user_id: user.id,
          award: {time: nil, name: nil}}, xhr: true
      end
        .to change(Award, :count).by 0
    end
  end

  describe "PATCH #update" do
    it "updated award successfully" do
      award = user.awards.create(time: "2017", name: "award")
      award.save
      patch :update, params: {user_id: user.id, id: award.id,
        award: {time: "2017", name: "award changed"}}, xhr: true
      expect((Award.find_by id: award.id).name)
        .to eq "award changed"
    end

    it "updated award with invalid params" do
      award = user.awards.create(time: "2017", name: "award")
      award.save
      patch :update, params: {user_id: user.id, id: award.id,
        award: {time: nil, name: "award changed"}}, xhr: true
      expect((Award.find_by id: award.id).name)
        .to eq "award"
    end
  end

  describe "DELETE #destroy" do
    context "award doesn't belongs to user" do
      let!(:award_another){FactoryGirl.create :award, user: another_user}

      it "delete_fail" do
        expect do
          delete :destroy, params: {user_id: user.id, id: award_another.id},
            xhr: true
        end
          .to change(Award, :count).by 0
      end
    end

    context "award belongs to user" do
      it "delete success" do
        expect do
          delete :destroy, params: {user_id: user.id, id: award.id}, xhr: true
        end
          .to change(Award, :count).by -1
      end
    end
  end
end
