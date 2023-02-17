class Api::V1::UploadsController < ApplicationController
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
end