import '../../data/models/ChatMessage.dart';

class ChatState {
  final List<ChatMessage> messages;
  ChatState({this.messages = const []});
}