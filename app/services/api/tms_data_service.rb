class Api::TmsDataService
  def initialize current_user, user_token
    @url = Settings.api.tms_data_link
    @current_user = current_user
    @auth_token = user_token
  end

  def synchronize_tms_data
    params = {email: @current_user.email}
    http_request = Api::HttpActionService.new @url, params, @auth_token
    response = http_request.get_data
    if response && response.code.to_i == 200
      return synchronize_data JSON.parse response.body
    end
    false
  end

  def tms_user_exist?
    params = {email: @current_user.email}
    http_request = Api::HttpActionService.new @url, params, @auth_token
    response = http_request.get_data
    response && response.code.to_i == 404 ? false : true
  end

  private

  def synchronize_user_school data_user
    if data_user["profile"]["university"]
      school = School.find_or_create_by name: data_user["profile"]["university"]
      user_school = UserSchool.find_or_create_by school_id: school.id,
        user_id: @current_user.id
      user_school.update_attributes end_date: data_user["profile"]["graduation"]
    end
  end

  def synchronize_user_programming_language data_user
    if data_user["profile"]["language"]
      ProgrammingLanguage.find_or_create_by name:
        data_user["profile"]["language"]
    end
  end

  def synchronize_user_courses_data data_user
    if data_user["profile"]
      language = data_user["profile"]["language"]
    else
      language = "unknown"
    end

    if data_user["courses"]
      data_user["courses"].each do |data_course|
        synchronize_user_course data_course, language
      end
    end
  end

  def synchronize_user_course data_course, language
    course = Course.find_or_create_by name: data_course["name"]
    programming_language = ProgrammingLanguage.find_by name: language
    course.update_attributes start_date: data_course["start_date"],
      end_date: data_course["end_date"], status: data_course["status"],
      programming_language_id: programming_language.id
    UserCourse.find_or_create_by course_id: course.id, user_id: @current_user.id

    synchronize_user_subject data_course, course.id
  end

  def synchronize_user_subject data_course, course_id
    if data_course["subjects"]
      data_course["subjects"].each do |data_subject|
        subject = Subject.find_or_create_by name: data_subject["subject_name"]

        user_course_subject = UserCourseSubject.find_or_create_by user_id:
          @current_user.id, course_id: course_id, subject_id: subject.id
        user_course_subject.update_attributes start_date:
          data_subject["start_date"], end_date: data_subject["end_date"],
          status: data_subject["status"]

        synchronize_user_task data_subject, course_id, subject.id
      end
    end
  end

  def synchronize_user_task data_subject, course_id, subject_id
    if data_subject["tasks"]
      data_subject["tasks"].each do |data_task|
        task_type = data_task.keys[0]
        task = Task.find_or_create_by name: data_task[task_type]["name"],
          task_type: task_type, subject_id: subject_id
        task.update_attributes description: data_task[task_type]["content"]
        user_task = UserTask.find_or_create_by user_id: @current_user.id,
          task_id: task.id, subject_id: subject_id, course_id: course_id
        user_task.update_attributes status: data_task[task_type]["status"]
      end
    end
  end

  def synchronize_user_skill response_json
    response_json["data"]["user"]["courses"].each do |course|
      skills = course["subjects"]
      update_user_skill_data skills
    end
  end

  def update_user_skill_data skills
    skills.each do |skill_json|
      skill = Skill.find_or_create_by name: skill_json["subject_name"]
      SkillUser.find_or_create_by skill_id: skill.id,
        user_id: @current_user.id
    end
  end

  def synchronize_data response_json
    begin
      ActiveRecord::Base.transaction do
        data_user = response_json["data"]["user"]
        synchronize_user_school data_user
        synchronize_user_programming_language data_user
        synchronize_user_courses_data data_user
        # synchronize_user_skill response_json
      end
    rescue StandardError
      return false
    end
    true
  end
end
