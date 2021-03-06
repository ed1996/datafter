class RecipientsMemoriesController < ApplicationController

  def destroy
    @recipients_memory = RecipientsMemory.find(params[:id])
    memory = @recipients_memory.memory

    @recipients_memory.destroy

    @recipients_memories = RecipientsMemory.where(memory_id: memory.id)

    respond_to do |format|
      format.json { render json: @recipients_memories }
    end
  end

end
