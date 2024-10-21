import 'package:colin_hanbury_frontend/models/chat_message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatService {
  final url = dotenv.env['WEB_SOCKET_URL'];
  final user = 'user';
  WebSocketChannel? channel;

  Stream getChatChannel() {
    final wsUrl = Uri.parse('$url/$user');
    return WebSocketChannel.connect(wsUrl).stream.asBroadcastStream();
  }

  dynamic sendMessage(ChatMessage chatMessage) {
    try {
      channel?.sink.add(chatMessage);
      return true;
    } catch (error) {
      return error;
    }
  }
}
