class PicturesController < ApplicationController

  def destroy
    @picture = Picture.find(params[:id])
    animal = @picture.animal

    @picture.destroy

    @pictures = Picture.where(animal_id: animal.id)

    respond_to do |format|
      format.json { render json: @pictures }
    end
  end

end
