class MemoriesController < ApplicationController

  before_action :set_memory, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @memory = current_user.memory
    @user = current_user
    if !@memory
      @memory = Memory.new
      new
      render :new
    else
      edit
      render :edit
    end
  end

  def show
    @memory = current_user.memory
    if !@memory
      new
    else
      edit
    end
  end

  def new
    @memory = Memory.new
  end

  def edit
    @recipients_memory = @memory.recipients_memories
    @memory = current_user.memory
  end

  def create
    @memory = Memory.new(memory_params)
    current_user.memory = @memory
    if @memory.save
      redirect_to edit_memory_path(@memory), notice:"Vos mémoires ont bien été enregistrées"
    else
      render :new
    end
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

  def save_recipients_memories
    if params[:recipients]
      params[:recipients].each do |i|
        @memory.recipients_memories.create(recipient: i, status: 'not_send')
      end
    end
    @recipients_memories = @memory.recipients_memories
  end

  def memory_params
    params.require(:memory).permit(:body)
  end
end
