class HommagesController < ApplicationController

  before_action :set_hommage, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @hommages = current_user.hommages
  end

  def new
    @hommage = current_user.hommages.build
  end

  def create
    @hommage = current_user.hommages.build(hommage_params)
    if @hommage.save
      if params[:images]
          params[:images].each do |i|
            @hommage.photos.create(image: i)
          end
      end
      @photos = @room.photos
      redirect_to edit_hommage_path(@hommage), notice:"Votre annonce a été ajouté avec succès"
    else
      render :new
    end
  end

  def show
    @photos = @hommage.photos
  end

  def edit
    @photos = @hommage.photos
  end

  def update
    if @hommage.update(hommage_params)
      if params[:images]
        params[:images].each do |i|
          @hommage.photos.create(image: i)
        end
      end
      @photos = @room.photos
      redirect_to edit_hommage_path(@hommage), notice:"Modification enregistrée..."
    else
      render :edit
    end
  end

  private
  def set_hommage
    @hommage = Hommage.find(params[:id])
  end

  def hommage_params
    params.require(:hommage).permit(:Nom, :Prenom, :date_naissance, :date_deces, :lieu_enterrement, :description)
  end

  def require_same_user
    if current_user.id != @hommage.user_id
      flash[:danger] = "Vous n'avez pas le droit de modifier cette page"
      redirect_to root_path
    end
  end

end
