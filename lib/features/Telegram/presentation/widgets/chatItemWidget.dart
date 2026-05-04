import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chatBloc/chatBloc.dart';
import '../../domain/entities/chatEntity.dart';
import '../bloc/chatBloc/blocEvent.dart';

class ChatItemWidget extends StatelessWidget {
  final ChatEntity chat;
  const ChatItemWidget({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(chat.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<ChatBloc>().add(DeleteChatEvent(chat.id));
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(chat.profileUrl)),
        title: Text(chat.senderName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(chat.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(chat.timestamp.toString().substring(11, 16)),
            SizedBox(
              height: 5,
            ),
            if (chat.unreadCount > 0)
              CircleAvatar(radius: 10,
                  child: Text(chat.unreadCount.toString(),
                      style: const TextStyle(fontSize: 10))),
          ],
        ),
      ),
    );
  }
}