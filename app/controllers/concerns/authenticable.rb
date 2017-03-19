module Authenticable
  
  def current_user
    @current_user ||= User.find_by(access_token: request.headers["Authorization"])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                 status: :unauthorized unless current_user.preset?
  end
end
