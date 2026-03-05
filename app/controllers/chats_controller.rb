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
    @chat = Chat.all(user: current_user)
    @chat = current_user.chat

  end

end
