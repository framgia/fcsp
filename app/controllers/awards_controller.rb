class AwardsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user
  before_action :load_award, only: [:edit, :update, :destroy]

  def new
    @award = @user.awards.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @award = @user.awards.build award_params
    if @award.save
      render_js t(".create_success"), 200
    else
      render_js t(".create_error"), 400
    end
  end

  def edit
  end

  def update
    if @award.update_attributes award_params
      render_js t(".update_success"), 200
    else
      render_js t(".update_error"), 400
    end
  end

  def destroy
    if @award.destroy
      render_js t(".delete_success"), 200
    else
      render_js t(".delete_error"), 400
    end
  end

  private
  def award_params
    params.require(:award).permit :name, :time
  end

  def load_award
    @award = Award.find_by id: params[:id]
    unless @award && @award.user == current_user
      flash[:danger] = t ".award_not_found"
      redirect_to root_path
    end
  end

  def load_user
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t ".user_not_found"
      redirect_to root_path
    end
  end

  def get_list_awards
    @awards = @user.awards.newest
  end

  def render_js message, status
    get_list_awards
    @render = Supports::Award.new message, status
    respond_to do |format|
      format.js
    end
  end
end
