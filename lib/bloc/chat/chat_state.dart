import 'package:colin_hanbury_frontend/models/chat_message.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus {
  initial,
  successful,
  loading,
  error,
}

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatMessage> chatMessages;
  final String error;

  ChatState(
      {this.status = ChatStatus.initial,
      List<ChatMessage>? chatMessages,
      String? error})
      : chatMessages = chatMessages ?? [],
        error = error ?? '';
  @override
  List<Object?> get props => [status, chatMessages];

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessage>? chatMessages,
    String? error,
  }) {
    if (chatMessages != null) {
      if (chatMessages.isNotEmpty) chatMessages += this.chatMessages;
    }
    return ChatState(
      status: status ?? this.status,
      chatMessages: chatMessages ?? this.chatMessages,
    );
  }
}
