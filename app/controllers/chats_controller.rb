class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @messages = @chat.messages.order(:created_at)
    @chats = current_user.chats.with_messages
  end

  def create
    @chat = Chat.create!(user: current_user, title: "Untitled")
    @chat.save
    redirect_to chat_path(@chat)

  end

  def index
    # @message = Message.find(params[:massage_id])
    # @messages = Message.all(user: current_user)
    @chats = Chat.all(user: current_user.chat) && !@chat.empty?
    # @chat = current_user.chats.where(message: @message)
    # @chat = Chat.new
  end
end
