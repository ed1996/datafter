class HommagesController < ApplicationController

  before_action :set_hommage, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    limit = params[:limit] || 10
    page = params[:page] || 10
    offset = ((page.to_i - 1) * limit.to_i) || 0
    term = params[:term] || nil
    hommages = []
    hommages = current_user.hommages
                   .where('last_name LIKE ? '\
                          'OR first_name LIKE ?', "%#{term}%", "%#{term}%")
                   .limit(limit)
                   .offset(offset) if term
    render json: hommages
=begin
    @q = current_user.hommages.ransack(params[:q])
    @hommages = @q.result
=end
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
      @photos = @hommage.photos
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
      @photos = @hommage.photos
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
    params.require(:hommage).permit(:last_name, :first_name, :date_birth, :date_death, :burial_place, :description)
  end

  def require_same_user
    if current_user.id != @hommage.user_id
      flash[:danger] = "Vous n'avez pas le droit de modifier cette page"
      redirect_to root_path
    end
  end

end
