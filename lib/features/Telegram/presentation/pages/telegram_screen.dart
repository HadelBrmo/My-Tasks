import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/features/Telegram/presentation/widgets/chatItemWidget.dart';

import '../bloc/chatBloc/chatBloc.dart';
import '../bloc/chatBloc/blocEvent.dart';
import '../bloc/chatBloc/blocState.dart';
import '../widgets/telegramDrawer.dart';

class ChatListScreen extends StatefulWidget {
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool _isSearching = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Colors.deepPurple,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () {

          print("فتح قائمة جهات الاتصال أو بدء محادثة");
        },
      ),

    appBar: AppBar(
      title: _isSearching
          ? TextField(
        controller: _searchController,
        autofocus: true,
        decoration: InputDecoration(hintText: "البحث...", border: InputBorder.none),
        onChanged: (value) {
          context.read<ChatBloc>().add(SearchChatsEvent(value));
        },
      )
          : const Text('Telegram'),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
                context.read<ChatBloc>().add(LoadChatsEvent());
              }
            });
          },
        ),
      ],
    ),
     drawer: const TelegramDrawer(),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatLoaded && state.deletedChatId != null) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('تم حذف المحادثة'),
                action: SnackBarAction(
                  label: 'تراجع',
                  onPressed: () {
                    context.read<ChatBloc>().add(UndoDeleteEvent());
                  },
                ),
                duration: const Duration(seconds: 4),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) return const Center(child: CircularProgressIndicator());

          if (state is ChatLoaded) {
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (context, index) {
                final chat = state.chats[index];
                return ChatItemWidget(chat: chat);
              },
            );
          }
          return const Center(child: Text("ابدأ بمراسلة أصدقائك"));
        },

      ),
    );
  }
}