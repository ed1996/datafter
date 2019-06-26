class MessagesController < ApplicationController

  before_action :set_message, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:search, :show]
  before_action only: [:edit, :update] do
    require_same_user(@message)
  end
  before_action :require_subscribed!, except: [:search, :show]
=begin
  before_action :add_breadcrumbs_list_messages, only: [:index, :show, :new, :edit]
=end


  def search
    @q = Message.ransack(params[:q])
    respond
  end

  def index
    @q = current_user.messages.find(params[:q])
    not_search
    respond
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.status = 'not_send'
    if @message.save
      save_recipients_messages
      redirect_to edit_message_path(@message), notice:"Votre message a été ajouté avec succès"
    else
      render :new
    end
  end

  def show
    @recipients_messages = @message.recipients_messages
  end

  def edit
    @recipients_messages = @message.recipients_messages
  end

  def update
    if @message.update(message_params)
      save_recipients_messages
      redirect_to edit_message_params(@message), notice:"Modification enregistrée..."
    else
      render :edit
    end
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end

  def respond
    @messages = @q.result(distinct: true)
    @messages = @messages.paginate(:page => params[:page], :per_page => 20).order('id DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
      format.js
    end
  end

  def save_recipients_messages
    if params[:recipients]
      params[:recipients].each do |i|
        i.status = 'not_send'
        @message.recipients_messages.create(recipient: i)
      end
    end
    @recipients_messages = @message.recipients_messages
  end

  def message_params
    params.require(:message).permit(:content, :object)
  end
end
