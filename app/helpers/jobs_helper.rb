module JobsHelper
  def select_hiring_type
    HiringType.all.map{|key| [key.name, key.id]}
  end

  def shared_job? job
    @shared_job_ids.include? job.id if @shared_job_ids.present?
  end

  def load_image_job job, options = {}
    if job.images.present?
      if job.images.first.picture.present?
        image_tag job.images.first.picture, class: options[:class].to_s,
          size: options[:size].to_s
      else
        image_tag Settings.jobs.image_url, class: options[:class].to_s,
          size: options[:size].to_s
      end
    else
      image_tag Settings.jobs.image_url, class: options[:class].to_s,
        size: options[:size].to_s
    end
  end

  def active_button job
    if job.active?
      button_tag t(".close"), id: job.id,
        class: "close-job btn btn-warning btn-xs"
    else
      button_tag t(".public"), id: job.id,
        class: "public-job btn btn-success btn-xs"
    end
  end

  def delete_button job
    if job.candidates.blank?
      button_tag t(".delete"), id: job.id,
        class: "delete-job btn btn-danger btn-xs"
    elsif job.draft?
      button_tag t(".draft"), id: job.id,
        class: "draft-job btn btn-danger btn-xs", disabled: true
    else
      button_tag t(".draft"), id: job.id,
        class: "draft-job btn btn-danger btn-xs"
    end
  end

  def status_group job
    if job.active?
      content_tag :strong, "#{Job.human_enum_name :status, job.status}",
        class: "label label-info"
    elsif job.draft?
      content_tag :strong, "#{Job.human_enum_name :status, job.status}",
        class: "label label-default"
    else
      content_tag :strong, "#{Job.human_enum_name :status, job.status}",
        class: "label label-warning"
    end
  end
end
