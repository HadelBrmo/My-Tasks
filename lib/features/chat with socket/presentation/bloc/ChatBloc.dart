import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/socket_service.dart';
import '../../data/models/ChatMessage.dart';
import 'ChatEvent.dart';
import 'ChatState.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState(messages: [
    ChatMessage(text: "مرحباً,نشكرك على تواصلك معنا ,سيتم  التواصل معك باقرب وقت ممكن", isMe: false, timestamp: DateTime.now()),
  ]))  {

    //تابع استقبال الرسائل
    on<ReceiveMessageEvent>((event, emit) {
      final updatedMessages = List<ChatMessage>.from(state.messages)..add(event.message);

      emit(ChatState(messages: updatedMessages));
    });

    //تابع ارسال الرسالة
    on<SendMessageEvent>((event, emit) {
      SocketService().sendMessageToRoom('order_555', event.text);
      final now = DateTime.now();
      SocketService().sendMessageToRoom('order_555', event.text);

      final myMessage = ChatMessage(
        text: event.text,
        isMe: true,
        timestamp: now,
      );
      final updatedMessages = List<ChatMessage>.from(state.messages)..add(myMessage);
      emit(ChatState(messages: updatedMessages));
    });
  }
}