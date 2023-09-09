class Api::V1::UploadsController < ApiController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  before_action :check_admin, only: [:create, :destroy, :update]
  def create
    newImage = Upload.new
    # note that the 'file' key for the 'newImage' hash corresponds to the field
    # in the database table where the image file reference is stored
    newImage.photo = params["photo"]
    newImage.post = current_post
    if newImage.save
      render json: Upload.last
    end
  end

  private
  
  def check_admin
    unless current_user.admin?
      flash[:alert] = "You don't have permission to do that."
      redirect_to root_path
    end
  end
end