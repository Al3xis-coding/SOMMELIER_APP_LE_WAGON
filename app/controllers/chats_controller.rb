class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @chat = Chat.create!(user: current_user)
    redirect_to chat_path(@chat)
  end

  def index
    @message = Message.find(params[:massage_id])
    @chat = current_user.chats.where(message: @message) && !@chat.empty?
    @chat = Chat.new
    @chats = Chat.all(user: current_user.chat)
    @messages = Message.all(user: current_user)
  end
end
