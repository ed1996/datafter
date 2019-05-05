class HommagesController < ApplicationController

  before_action :set_hommage, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @hommages = current_user.hommages
  end

  def new
    @hommage = current_user.hommages.build
  end

  def create
    @hommage = current_user.hommages.build(hommage_params)
    if @hommage.save
      redirect_to @hommage, notice:"Votre annonce a été ajouté avec succès"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @hommage.update(hommage_params)
      redirect_to @hommage, notice:"Modification enregistrée..."
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

end
