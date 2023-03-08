class Users::SessionsController < Devise::SessionsController
  include RackSessionFix

  def failure
    self.status = :unauthorized
    self.content_type = "application/json"
    self.response_body = { code: 401, message: "Invalid email or password." }.to_json
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end