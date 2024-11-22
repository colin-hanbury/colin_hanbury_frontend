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
  final messageInputController = TextEditingController();
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
      builder: (context, state) {
        switch (state.status) {
          case ChatStatus.error:
            return Stack(
              children: [
                const SizedBox(),
                _showAlert(state.error),
              ],
            );
          default:
            return Stack(
              children: [
                const SizedBox(),
                _showAlert(state.error),
              ],
            );
        }
      },
    );
  }

  Widget _messages(ChatState state) => ListView.builder(
        itemBuilder: (context, index) => Align(
          alignment: state.chatMessages[index].sender == 'this user'
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(
              10.0,
            ),
            child: Text(state.chatMessages[index].message ?? ''),
          ),
        ),
      );

  Widget _showAlert(String error) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: Text(error),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
    return const SizedBox();
  }

  Widget _messageInput() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: messageInputController,
          decoration: const InputDecoration(
            hintText: 'Type your message here',
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'Enter your name' : null,
        ),
      );
}
