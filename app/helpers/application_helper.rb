module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def not_found
    render file: "public/404.html", layout: false, status: 404
  end

  def check_paginator? page
    page.left_outer? || page.right_outer? || page.inside_window?
  end
end
