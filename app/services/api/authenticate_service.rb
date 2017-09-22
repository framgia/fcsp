class Api::AuthenticateService
  def initialize email, password
    @params = {"sign_in[email]": email, "sign_in[password]": password}
    @url = Settings.api.tms_login_link
  end

  def tms_authenticate
    http_request = Api::HttpActionService.new @url, @params
    response_json = http_request.post_data
    if response_json
      response_json.code.to_i != 200 ? false : JSON.parse(response_json.body)
    end
  end
end
