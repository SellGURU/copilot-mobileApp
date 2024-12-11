/// The `Message` class represents a single message within a conversation,
/// either sent by the user or generated as a response by the system (AI).
class Message {
  final String sender; // The sender of the message, e.g., "User" or "Ai"
  final String text; // The text content of the message
  final String time; // The timestamp when the message was sent
  final String avatarUrl; // URL or path to the avatar image of the sender
  final List<String> images; // A list of image URLs associated with the message (for requests)

  /// Constructor for the `Message` class.
  ///
  /// [sender] is the name or identifier of the sender (e.g., "User" or "Ai").
  /// [text] is the content of the message.
  /// [time] is the time when the message was sent.
  /// [avatarUrl] is the URL/path of the sender's avatar.
  /// [images] is a list of image URLs associated with the message (default is an empty list).
  Message({
    required this.sender,
    required this.text,
    required this.time,
    required this.avatarUrl,
    this.images = const [], // Default to an empty list if no images
  });

  /// Factory constructor to create a `Message` from a user's request data.
  ///
  /// [entry] is a map containing the message data from the server.
  factory Message.fromRequest(Map<String, dynamic> entry) {
    return Message(
      sender: "User", // Sender is always "User" for requests
      text: entry['request']['text'], // Extract text from the request
      time: entry['entrytime'].split(' ')[1], // Extract time from the entrytime field
      avatarUrl: "assets/avatar12.svg", // Default avatar URL for user
      images:
      List<String>.from(entry['request']['images']), // Extract images if available
    );
  }

  /// Factory constructor to create a `Message` from the AI's response.
  ///
  /// [entry] is a map containing the response data from the server.
  factory Message.fromResponse(Map<String, dynamic> entry) {
    return Message(
      sender: "Ai", // Sender is always "Ai" for responses
      text: entry['response'], // Extract the response text
      time: entry['entrytime'], // Use the entrytime for the response's timestamp
      avatarUrl: "assets/avatar12.svg", // Default avatar URL for AI
      images: [], // No images for AI responses
    );
  }
}

/// Abstract class representing the state of the chat conversation.
abstract class ChatState {
  const ChatState();

  @override
  List<Object?> get props => []; // Override to allow comparison of states
}

/// Represents the initial state of the chat before any messages are loaded.
class ChatInitial extends ChatState {}

/// Represents the loading state while fetching messages or performing an action.
class ChatLoading extends ChatState {}

/// Represents the loaded state when the messages have been successfully fetched.
class ChatLoaded extends ChatState {
  final List<Message> messages; // A list of messages for the loaded state

  const ChatLoaded(this.messages);

  @override
  List<Object?> get props => [messages]; // Include messages in state comparison
}

/// Represents an error state with a message describing the error.
class ChatError extends ChatState {
  final String message; // The error message

  const ChatError(this.message);

  @override
  List<Object?> get props => [message]; // Include the error message in state comparison
}

/// Represents the initial state of the chat history before it is loaded.
class ChatHistoryInitial extends ChatState {}

/// Represents the loading state while fetching the chat history.
class ChatHistoryLoading extends ChatState {}

/// Represents the loaded state when the chat history has been successfully fetched.
class ChatHistoryLoaded extends ChatState {
  final List<Message> messages; // A list of messages in the chat history

  const ChatHistoryLoaded(this.messages);

  @override
  List<Object?> get props => [messages]; // Include messages in state comparison
}

/// Represents an error state while fetching the chat history.
class ChatHistoryError extends ChatState {
  final String message; // The error message

  const ChatHistoryError(this.message);

  @override
  List<Object?> get props => [message]; // Include the error message in state comparison
}
