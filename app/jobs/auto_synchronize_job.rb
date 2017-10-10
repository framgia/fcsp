class AutoSynchronizeJob < ApplicationJob
  queue_as :default

  def perform
    authen_service = Api::AuthenticateService.new(ENV["TMS_ADMIN_EMAIL"],
      ENV["TMS_ADMIN_PASSWORD"]).tms_authenticate
    if authen_service
      auth_token = authen_service["authen_token"]
      User.all.want_auto_sync.each do |user|
        Api::TmsDataService.new(user, auth_token).synchronize_tms_data
      end
    end
  end
end
