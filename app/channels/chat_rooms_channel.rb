class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
  end
end


# subscribed is a special method to start streaming from a channel with a given name. As long as we have multiple rooms, the channel’s name will vary. Remember, we provided chat_room_id: messages.data('chat-room-id') when subscribing to a channel in our script? Thanks to it, chat_room_id can be fetched inside the subscribed method by calling params['chat_room_id'].

# unsubscribed is a callback that fires when the streaming is stopped, but we won’t use it in this demo.

# The last method – send_message – fires when we run @perform 'send_message', message: message, chat_room_id: chat_room_id from our script. The data variable contains a hash of sent data, so, for example, to access the message you would type data['message'].

# There are multiple ways to broadcast the received message, but I am going to show you a very neat solution based on the demo provided by DHH (I’ve also found this article with a slightly different approach).