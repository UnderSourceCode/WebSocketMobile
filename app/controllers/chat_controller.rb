class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def initialize_session
    puts "Session Initialized\n"
  end

  def system_msg(ev, msg)
    broadcast_message ev, {
        user_name: 'system',
        received: Time.now.strftime('%m/%d %H:%M'),
        msg_body: msg
    }
  end

  def user_msg(ev, msg)
    broadcast_message ev, {
        user_name:  connection_store[:user][:user_name],
        received:   Time.now.strftime('%m/%d %H:%M'),
        msg_body:   ERB::Util.html_escape(msg)
    }
  end

  def client_connected
    system_msg :new_message, "client #{client_id} connected"
  end

  def new_message
    user_msg :new_message, message[:msg_body].dup
  end

  def new_user
    connection_store[:user] = { user_name: sanitize(message[:user_name]) }
  end

  def change_username
    connection_store[:user][:user_name] = sanitize(message[:user_name])
  end

  def delete_user
    connection_store[:user] = nil
    system_msg "client #{client_id} disconnected"
  end

end
