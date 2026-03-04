class MessagesController < ApplicationController
  SYSTEM_PROMPT = "You are a renown sommelier in France. A user gives you a specific meal and you ahve to propose 3 to 5 wines that would be great with."
  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    @ruby_llm_chat = RubyLLM.chat

    if @message.save
      build_conversation_history
      response = @ruby_llm_chat.with_instructions(instructions).ask(@message.content)
      @chat.messages.create(role: "assistant", content: response.content)

      respond_to do |format|
        format.turbo_stream # renders `app/views/messages/create.turbo_stream.erb`
        format.html { redirect_to chat_path(@chat) }
      end

    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.update("new_message_container", partial: "messages/form", locals: { chat: @chat, message: @message }) }
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def user_taste
    taste = current_user.tastes.presence
    "Here is the user tastes: #{taste}." if taste
  end

  def instructions
    [SYSTEM_PROMPT, user_taste].compact.join("\n\n")
  end

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(role: message.role, content: message.content)
    end
  end
end
