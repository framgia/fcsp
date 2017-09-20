module CoursesHelper
  def check_language course
    if language = course.programming_language.name
      language.downcase!
      url = "/assets/course/" << language << ".jpg"
    else
      url = "/assets/course/no_image.jpg"
    end
  end
end
