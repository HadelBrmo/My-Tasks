import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/socket_service.dart';
import '../../../../core/utils/app_colors/app_colors.dart';
import '../../data/models/ChatMessage.dart';
import '../bloc/ChatBloc.dart';
import '../bloc/ChatEvent.dart';
import '../bloc/ChatState.dart';

class ChatScreen extends StatefulWidget {
  final String orderId;
  const ChatScreen({super.key, required this.orderId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    SocketService().joinRoom(widget.orderId);

    SocketService().listenToRoomMessages((data) {
      final newMessage = ChatMessage(
        text: data['message'],
        isMe: false,
        timestamp: DateTime.parse(data['timestamp']),
      );
      context.read<ChatBloc>().add(ReceiveMessageEvent(newMessage));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Chat screen",
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),


        backgroundColor: AppColors.black,

        centerTitle: true,

        shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.vertical(

            bottom: Radius.circular(12),

          ),

        ),


      ),
      backgroundColor: AppColors.black,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/myPhoto2.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      return Align(
                        alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child:
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: msg.isMe ? Colors.black : Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(msg.text, style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 5),
                              Text(
                                "${msg.timestamp.hour}:${msg.timestamp.minute}",
                                style: TextStyle(color: Colors.white70, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
              controller: _controller,
                style: const TextStyle(
                  color: Colors.white,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "اكتب رسالتك...",
                  hintStyle: const TextStyle(
                    color: Colors.white70,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),

                  fillColor: Colors.transparent,
                  filled: true,
                ),
              ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send,color: AppColors.white,),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        context.read<ChatBloc>().add(SendMessageEvent(_controller.text));
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
