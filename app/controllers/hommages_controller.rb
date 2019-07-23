class HommagesController < ApplicationController

  before_action :set_hommage, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:search, :list, :show]
  before_action only: [:edit, :update] do
    require_same_user(@hommage)
  end

  before_action :require_subscribed!, except: [:search, :list, :show]
  before_action :add_breadcrumbs_list_hommages, only: [:index, :search, :show, :new, :edit]
  before_action :add_breadcrumbs_hommages, only: [:index, :search, :list, :show, :edit, :new]
  before_action :add_breadcrumbs_detail_hommage, only: [:show, :edit]
  before_action :add_breadcrumbs_edit_hommage, only: [:edit]

  def search
    @q = Hommage.ransack(params[:q])
    respond
  end

  def index
    @q = current_user.hommages.ransack(params[:q])
    not_search
    respond
  end

  def list
    @q = Hommage.ransack(params[:q])
    not_search
    add_breadcrumbs_hommages
    add_breadcrumbs_list_hommages
    respond
  end

  def new
    @hommage = current_user.hommages.build
    add_breadcrumb "Rendre un hommage"
  end

  def create
    @hommage = current_user.hommages.build(hommage_params)
    if @hommage.save
      save_photos
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
      save_photos
      redirect_to edit_hommage_path(@hommage), notice:"Modification enregistrée..."
    else
      render :edit
    end
  end

  private
  def set_hommage
    @hommage = Hommage.friendly.find(params[:id])
  end

  def respond
    @hommages = @q.result(distinct: true)
    @hommages = @hommages.paginate(:page => params[:page], :per_page => 10).order('id DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hommages }
      format.js
    end
  end

  def save_photos
    if params[:images]
      params[:images].each do |i|
        @hommage.photos.create(image: i)
      end
    end
    @photos = @hommage.photos
  end

  def hommage_params
    params.require(:hommage).permit(:last_name, :first_name, :date_birth, :date_death, :burial_place, :description)
  end
end
