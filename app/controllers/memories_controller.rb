class MemoriesController < ApplicationController

  before_action :set_memory, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :require_same_user, only: [:edit, :update]

  def index

    @memory = current_user.memory

  end

  def update
    if @memory.update(memory_params)
      redirect_to edit_hommage_path(@hommage), notice:"Modification enregistrée..."
    else
      render :edit
    end
  end

  private
  def set_memory
    @memory = Memory.find(params[:id])
  end

  def memory_params
    params.require(:memory).permit(:body, :receivers)
  end
end
