class PhotosController < ApplicationController

  def destroy
    @photo = Photo.find(params[:id])
    hommage = @photo.hommage

    @photo.destroy

    @photos = Photo.where(hommage_id: hommage.id)

    respond_to do |format|
      format.json { render json: @photos }
    end
  end

end
