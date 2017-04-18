class UserSkill
  def initialize job, users
    @job = job
    @users = users
  end

  def user_sort_skill
    arr = Array.new
    @users.find_each do |user|
      arr << user unless (user.skills & @job.skills).empty?
    end
    sort_skill arr
  end

  private

  def sort_skill arr
    arr.map{|user| [user, point_skill(user)]}
      .sort_by{|user, point| [(user.skills & @job.skills).length, point]}
      .reverse
  end

  def point_skill user
    point = Settings.number_skill_level
    (user.skills & @job.skills).each do |skill|
      skill = user.skill_users.find_by skill_id: skill.id
      point += skill.level
    end
    point
  end
end
