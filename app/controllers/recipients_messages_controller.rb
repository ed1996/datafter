class RecipientsMessagesController < ApplicationController

  def destroy
    @recipients_message = RecipientsMessage.find(params[:id])
    message = @recipients_message.message

    @recipients_message.destroy

    @recipients_messages = RecipientsMessage.where(message_id: message.id)

    respond_to :js
  end

end
