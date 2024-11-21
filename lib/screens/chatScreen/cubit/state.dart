class Message {
  final String sender;
  final String text;
  final String time;
  final String avatarUrl;
  final List<String> images; // To store image URLs for requests

  Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.avatarUrl,
    this.images = const [], // Default to an empty list if no images
  });

  // Factory constructor to create a request message (from the user)
  factory Message.fromRequest(Map<String, dynamic> entry) {
    return Message(
      sender: "User",
      text: entry['request']['text'],
      time: entry['entrytime'],
      avatarUrl: "path/to/user/avatar",
      images: List<String>.from(entry['request']['images'] ?? []), // Handle images array
    );
  }

  // Factory constructor to create a response message (from the system)
  factory Message.fromResponse(Map<String, dynamic> entry) {
    return Message(
      sender: "Ai",
      text: entry['response'],
      time: entry['entrytime'],
      avatarUrl: "path/to/system/avatar",
      images: [], // No images for the response
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
