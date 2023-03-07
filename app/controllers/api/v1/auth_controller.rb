class Api::V1::AuthController < ApplicationController
  def register
    user = User.new(user_params)

    if user.save
      render json: { message: 'User registered successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: 'Login successful' }, status: :ok
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    session[:user_id] = nil
    render json: { message: 'Logout successful' }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
