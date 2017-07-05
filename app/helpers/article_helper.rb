module ArticleHelper
  def check_time_show article
    return select_time_show time: {selected: :now} unless article.time_show?

    if article.time_show > Time.zone.now
      select_time_show time: {selected: :choose_time}
    else
      select_time_show time: {disabled: :now}
    end
  end

  private

  def select_time_show options = {}
    select_tag :show_time,
      options_for_select([[t(".now"), :now], [t(".time"), :choose_time]],
        options[:time])
  end
end
