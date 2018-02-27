class LanguagesController < ApplicationController
  def create
    language = Language.find_by name: params[:language][:name]

    if language
      user_language = current_user.user_languages.find_by language_id: language.id

      if user_language
        notice_fail_action
      else
        user_language = current_user.user_languages.build(
          language_id: language.id,
          level: params[:language][:user_languages_attributes]["0"][:level])

        if user_language.save
          load_user_language
        else
          notice_fail_action
        end
      end
    else
      language = Language.new language_params
      language.user_languages.first.user_id = current_user.id

      if language.save
        load_user_language
      else
        notice_fail_action
      end
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

  def language_params
    params.require(:language).permit :name,
      user_languages_attributes: [:level, :user_id]
  end
end
