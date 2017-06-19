require "rails_helper"

RSpec.describe Employer::CompaniesController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let(:industry){FactoryGirl.create :industry, name: "Viet Nam"}
  let(:address) do
    FactoryGirl.create :address, address: "HN", company_id: company.id
  end

  before :each do
    allow(controller).to receive(:current_user).and_return admin
    sign_in admin
  end

  describe "GET #edit" do
    it "edit company" do
      company_params = FactoryGirl.attributes_for :company,
        introduction: "something"
      get :edit, params: {id: company, address_id: address,
        industry_id: industry, company: company_params}
      expect(response).to render_template :edit
    end
  end

  describe "PUT #update" do
    it "update company" do
      company_params = FactoryGirl.attributes_for :company,
        introduction: "something"
      patch :update, params: {id: company, address_id: address,
        industry_id: industry, company: company_params}
      company.reload
    end
  end
end
