class UserLanguagesController < ApplicationController
  before_action :find_user_language, only: [:destroy, :update]

  def update
  end

  def destroy
    if @user_language.destroy
      load_user_language
    else
      notice_fail_action
    end
  end

  private

  def load_user_language
    @user_presenter = UserPresenter.new current_user

    render json: {
      status: :success,
      html: render_to_string(partial: "languages/current_language", layout: false)
    }
  end

  def find_user_language
    @user_language = current_user.user_languages.find_by id: params[:id]
    return if @user_language
    redirect_to edit_user_path current_user
  end

  def user_language_params
    params.require(:user_language).permit :level
  end
end
