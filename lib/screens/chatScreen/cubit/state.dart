class Message {
  final String sender;
  final String content;

  Message({required this.sender, required this.content});
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
