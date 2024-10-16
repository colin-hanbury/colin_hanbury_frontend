import 'package:flutter/material.dart';

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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: Container(), //_pageLayout(),
    );
  }

  // Widget _pageLayout() {
  //   return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {});
  // }
}
