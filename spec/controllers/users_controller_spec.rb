require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}

  before :each do
    allow(controller).to receive(:current_user).and_return(admin)
    sign_in admin
  end

  describe "GET #show/:id" do
    it "user found" do
      get :show, params: {id: admin.id}
      expect(response).to render_template :show
    end

    it "user not found" do
      get :show, params: {id: 999}
      expect(response).not_to render_template :show
    end
  end
end
