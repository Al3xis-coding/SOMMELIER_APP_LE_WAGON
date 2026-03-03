class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @chat.messages.create!(role: "user", content: params[:message][:content])

    ai_response = RubyLLM.chat.ask(@chat.messages.where(role: "user").last.content).content
    @chat.messages.create!(role: "assistant", content: ai_response)

    redirect_to chat_path(@chat)
  end
end
