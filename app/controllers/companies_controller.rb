class CompaniesController < ApplicationController
  def new
    company = Company.new
    company.groups.build
    @company_form = CompanyForm.new company
  end

  def create
    @company = Company.new
    params[:company][:groups_attributes].each do
      @company.groups.build
    end

    @company_form = CompanyForm.new @company
    if @company_form.validate params[:company].permit!
      @company_form.save
      flash[:success] = t ".created"
      redirect_to @company_form
    else
      render :new
    end
  end
end
