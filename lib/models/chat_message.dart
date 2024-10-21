class ChatMessage {
  final String? chatRoomId;
  final String? message;
  final String? sender;
  final List<String>? receivers;
  final DateTime? timestamp;

  ChatMessage({
    this.chatRoomId,
    this.message,
    this.sender,
    this.receivers,
    this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> response) {
    final messageData = response['message'];
    return ChatMessage(
      chatRoomId: response['roomId'],
      sender: messageData['sender'],
      receivers: messageData['recievers'] as List<String>,
      timestamp: DateTime.tryParse(messageData['timestamp']),
    );
  }
}
