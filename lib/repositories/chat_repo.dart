import 'package:colin_hanbury_frontend/models/chat_message.dart';
import 'package:colin_hanbury_frontend/services/chat_service.dart';

class ChatRepo {
  final ChatService chatService = ChatService();

  dynamic sendMessage(ChatMessage chatMessage) {
    try {
      chatService.sendMessage(chatMessage);
      return true;
    } catch (error) {
      return error.toString();
    }
  }

  Stream getMessages() =>
      chatService.getChatChannel().map((data) => ChatMessage.fromJson(data));
}
