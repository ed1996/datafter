class MessagesController < ApplicationController

  before_action :set_message, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:search, :show]
  before_action only: [:edit, :update] do
    require_same_user(@message)
  end
 # before_action :require_subscribed!, except: [:search, :show]
  before_action :add_breadcrumbs_messages, only: [:index, :search, :show, :edit, :new]
  before_action :add_breadcrumbs_detail_message, only: [:show, :edit]
  before_action :add_breadcrumbs_edit_message, only: [:edit]


  def search
    @q = Message.ransack(params[:q])
    respond
  end

  def index
    @q = current_user.messages.ransack(params[:q])
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

  def destroy
    @message = Message.friendly.find(params[:id])

    @recipients_messages = RecipientsMessage.where(message_id: @message.id)
    @recipients_messages.each do |i|
      i.destroy
    end
    @message.destroy

    redirect_to messages_path
  end

  def update
    if @message.update(message_params)
      save_recipients_messages
      redirect_to edit_message_path(@message), notice:"Modification enregistrée..."
    else
      render :edit
    end
  end

  private
  def set_message
    @message = Message.friendly.find(params[:id])
  end

  def respond
    @messages = @q.result(distinct: true)
    @messages = @messages.paginate(:page => params[:page], :per_page => 10).order('id DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
      format.js
    end
  end

  def save_recipients_messages
    if params[:recipients]
      @message.recipients_messages.destroy_all
      params[:recipients].each do |i|
        @message.recipients_messages.create(recipient: i, status: 'not_send')
      end
    end
    @recipients_messages = @message.recipients_messages
  end

  def message_params
    params.require(:message).permit(:content, :object)
  end
end
