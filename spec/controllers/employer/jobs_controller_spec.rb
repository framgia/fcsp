require "rails_helper"

RSpec.describe Employer::JobsController, type: :controller do
  let(:admin){FactoryGirl.create :user, role: 1}
  let(:company){FactoryGirl.create :company}
  let!(:job){FactoryGirl.create :job, company_id: company.id}
  arr_id_success = [1, 2]
  arr_id_fail = [998, 999]

  before :each do
    allow(controller).to receive(:current_user).and_return admin
    sign_in admin
    request.env["HTTP_REFERER"] = "sample_path"
  end

  describe "GET #index" do
    it "populates an array of jobs" do
      get :index, params: {company_id: company}
      expect(assigns(:jobs)).to include job
    end

    it "filter jobs with request xhr, populates an array of jobs" do
      get :index, params: {company_id: company, type: "status", sort: "ASC",
        array_id: [1, 2, 3], page: 1}, xhr: true
      expect(response).to render_template("employer/jobs/_job")
      expect(response).to render_template("employer/jobs/_paginate")
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status 200
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new, params: {company_id: company.id}
      expect(response).to render_template :new
    end
  end

  describe "POST #create job" do
    it "create community job successfully" do
      job_params = FactoryGirl.attributes_for :job
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 1
    end

    it "create job only preview" do
      job_params = FactoryGirl.attributes_for :job
      expect do
        post :create, params: {company_id: company, preview: "Preview",
          job: job_params}
      end.to change(Job, :count).by 1
    end

    it "create fail with title nil" do
      job_params = FactoryGirl.attributes_for :job, title: nil
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
    end

    it "create fail by reaching length limitation" do
      title = "a" * 151
      job_params = FactoryGirl.attributes_for :job, title: title
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
    end

    it "create fail with describe nil" do
      job_params = FactoryGirl.attributes_for :job, describe: nil
      expect do
        post :create, params: {company_id: company, job: job_params}
      end.to change(Job, :count).by 0
    end
  end

  describe "PUT #update" do
    it "update successfully with json" do
      job_params = FactoryGirl.attributes_for :job, title: "something"
      put :update, params: {company_id: company, id: job, job: job_params},
        xhr: true
      job.reload
      expect(response).to have_http_status 200
    end

    it "update successfully" do
      job_params = FactoryGirl.attributes_for :job, title: "something"
      put :update, params: {company_id: company, id: job, job: job_params},
        xhr: false
      job.reload
      expect(response).to redirect_to job
    end

    it "update fail with title nil" do
      job_params = FactoryGirl.attributes_for :job, title: nil
      put :update, params: {company_id: company, id: job, job: job_params},
        xhr: false
      job.reload
    end

    context "cannot load job" do
      before do
        allow(Job).to receive(:find_by).and_return nil
        get :update, params: {company_id: company, id: 999}
      end

      it "redirect to job_path" do
        expect(response).to redirect_to employer_company_jobs_path company
      end

      it "get a flash danger" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    context "delete successfully" do
      before{delete :destroy,
        params: {company_id: company, array_id: arr_id_success}}
      it{expect{response.to change(Job, :count).by - 2}}
    end

    it "delete fail" do
      allow_any_instance_of(Job).to receive(:destroy).and_return(false)
      expect do
        delete :destroy,
          params: {company_id: company, array_id: arr_id_fail}
      end.not_to change(Job, :count)
    end

    it "responds successfully with an HTTP 200 status code" do
      delete :destroy, params: {company_id: company, array_id: arr_id_success},
        xhr: true
      expect(response).to have_http_status 200
    end
  end
end
