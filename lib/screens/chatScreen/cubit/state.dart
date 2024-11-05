class Message {
  final String sender;
  final String text;
  final String time;
  final String avatarUrl;

  Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.avatarUrl,
  });

  // Factory constructor to create a request message (from the user)
  factory Message.fromRequest(String time, String requestText) {
    return Message(
      sender: "User",
      text: requestText,
      time: time,
      avatarUrl: "path/to/user/avatar", // Replace with actual user avatar path
    );
  }

  // Factory constructor to create a response message (from the system)
  factory Message.fromResponse(String time, String responseText) {
    return Message(
      sender: "Ai",
      text: responseText,
      time: time,
      avatarUrl: "path/to/system/avatar", // Replace with actual system avatar path
    );
  }
}



abstract class ChatState {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Message> messages;

  const ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatHistoryInitial extends ChatState {}

class ChatHistoryLoading extends ChatState {}

class ChatHistoryLoaded extends ChatState {
  final List<Message> messages;

  ChatHistoryLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatHistoryError extends ChatState {
  final String message;

  ChatHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
