import 'package:colin_hanbury_frontend/models/chat_message.dart';
import 'package:equatable/equatable.dart';

class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageSent extends ChatEvent {
  final ChatMessage message;

  MessageSent({required this.message});
  @override
  List<Object?> get props => [message];
}

class NewMessages extends ChatEvent {
  final List<ChatMessage> message;

  NewMessages({required this.message});
  @override
  List<Object?> get props => [message];
}

class ChatOpened extends ChatEvent {}
