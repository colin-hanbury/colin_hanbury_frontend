import 'dart:async';

import 'package:colin_hanbury_frontend/bloc/chat/chat_event.dart';
import 'package:colin_hanbury_frontend/bloc/chat/chat_state.dart';
import 'package:colin_hanbury_frontend/repositories/chat_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required this.chatRepo}) : super(ChatState()) {
    on<ChatOpened>(onChatOpened as EventHandler<ChatOpened, ChatState>);
    on<MessageSent>(onMessageSent as EventHandler<MessageSent, ChatState>);
    on<NewMessages>(onNewMessages as EventHandler<NewMessages, ChatState>);
  }

  final ChatRepo chatRepo;
  StreamSubscription<String>? chatMessagesSub;
  // Stream?

  void onMessageSent(MessageSent event, Emitter<ChatState> emitter) {
    emitter(state.copyWith(status: ChatStatus.loading));
    try {
      chatRepo.sendMessage(event.message);
    } catch (e) {
      emitter(state.copyWith(status: ChatStatus.error, error: e.toString()));
    }
  }

  void onChatOpened(ChatOpened event, Emitter<ChatState> emitter) {
    chatMessagesSub?.cancel();
    chatMessagesSub = chatRepo
            .getMessages()
            .listen((message) => add(NewMessages(message: message)))
        as StreamSubscription<String>?;
  }

  void onNewMessages(NewMessages event, Emitter<ChatState> emitter) {
    emitter(state.copyWith(
        status: ChatStatus.successful, chatMessages: event.message));
  }

  @override
  Future<void> close() {
    chatMessagesSub?.cancel();
    return super.close();
  }
}
