import '../../data/models/ChatMessage.dart';

abstract class ChatEvent {}

class ReceiveMessageEvent extends ChatEvent {
  final ChatMessage message;

  ReceiveMessageEvent(this.message);
}

class SendMessageEvent extends ChatEvent {
  final String text;
  SendMessageEvent(this.text);
}