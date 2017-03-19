module Authenticable
  
  def current_user
    @current_user ||= User.find_by(access_token: request.headers["Authorization"])
  end
end
