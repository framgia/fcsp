class Employer::CompaniesController < Employer::BaseController
  load_and_authorize_resource
  before_action :load_address, :load_industry, only: :edit

  def edit
  end

  def update
    if @company.update_attributes company_params
      flash[:success] = t ".company_updated"
    else
      flash[:danger] = t ".company_updated_failed"
    end
    redirect_to edit_employer_company_path
  end

  private

  def company_params
    params.require(:company).permit Company::ATTRIBUTES
  end

  def load_address
    @address = @company.addresses.head_office.first
  end

  def load_industry
    @industries = Industry.all
  end
end
