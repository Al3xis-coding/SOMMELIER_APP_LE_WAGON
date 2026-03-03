class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    if @message.save
      ai_response = RubyLLM.chat.ask(@message.content).content
      @chat.messages.create!(role: "assistant", content: ai_response)
      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
