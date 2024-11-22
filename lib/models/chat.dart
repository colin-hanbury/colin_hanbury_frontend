import 'package:colin_hanbury_frontend/models/chat_message.dart';

class Chat {
  final String? chatRoomId;
  final List<ChatMessage>? messages;
  final List<String>? members;

  Chat({
    this.chatRoomId,
    this.messages,
    this.members,
  });

  factory Chat.fromJson(Map<String, dynamic> response) {
    return Chat(
      chatRoomId: response['roomId'],
      messages: response['messages'] as List<ChatMessage>,
      members: response['members'] as List<String>,
    );
  }
}
