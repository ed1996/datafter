class AnimalsController < ApplicationController

  before_action :set_animal, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:search, :list, :show]
  before_action only: [:edit, :update] do
    require_same_user(@animal)
  end


  before_action :require_subscribed!, except: [:search, :list, :show, :edit, :update, :index]



  def search
    @q = Animal.ransack(params[:q])
    respond
  end

  def index
    @q = current_user.animals.ransack(params[:q])
    not_search
    respond
  end

  def list
    @q = Animal.ransack(params[:q])
    not_search
    respond
  end

  def new
    @animal = current_user.animals.build
    add_breadcrumb "Rendre un hommage"
  end

  def create
    @animal = current_user.animals.build(animal_params)
    if @animal.save
      save_pictures
#      redirect_to edit_animal_path(@animal), notice:"Votre annonce a été ajouté avec succès"
      redirect_to animals_path, notice:"Votre hommage a été ajouté avec succès"
    else
      render :new
    end
  end

  def show
    @pictures = @animal.pictures
  end

  def edit
    @pictures = @animal.pictures
  end

  def update
    if @animal.update(animal_params)
      save_pictures
      redirect_to edit_animal_path(@animal), notice:"Modification enregistrée..."
    else
      render :edit
    end
  end


  private
  def set_animal
    @animal = Animal.find(params[:id])
  end

  def respond
    @animals = @q.result(distinct: true)
    @animals = @animals.paginate(:page => params[:page], :per_page => 10).order('id DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @animals }
      format.js
    end
  end

  def save_pictures
    if params[:images]
        params[:images].each do |i|
        @animal.pictures.create(image: i)
      end
    end
    @pictures = @animal.pictures
  end

  def animal_params
    params.require(:animal).permit(:name, :date_birth, :date_death, :category, :description)
  end

end
