import 'package:colin_hanbury_frontend/bloc/chat/chat_bloc.dart';
import 'package:colin_hanbury_frontend/bloc/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          'Chat',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: _pageLayout(), //_pageLayout(),
    );
  }

  Widget _pageLayout() {
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) => const Text('Chat Page'));
  }
}
