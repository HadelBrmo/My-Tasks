import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../core/utils/constants/const.dart';

class ChatgptScreen extends StatefulWidget {
  const ChatgptScreen({super.key});

  @override
  State<ChatgptScreen> createState() => _ChatgptScreenState();
}

class _ChatgptScreenState extends State<ChatgptScreen> {
  final ChatUser currentUser = ChatUser(
    id: '1',
    firstName: "Hadel",
    lastName: "Brmo",
  );

  final ChatUser chatgptUser = ChatUser(
    id: '2',
    firstName: "AI",
    lastName: "Assistant",
  );

  List<ChatMessage> messages = [];

  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();

    final apiKey = OPEN_API_KEY;

    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,

      generationConfig: GenerationConfig(
        maxOutputTokens: 200,
        temperature: 0.7,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DashChat(
        currentUser: currentUser,
        messageOptions: MessageOptions(
          currentUserContainerColor: Colors.black,
          currentUserTextColor: Colors.white,

        ),
        inputOptions: InputOptions(
          inputTextStyle: const TextStyle(color: Colors.black),
          //hintStyle: TextStyle(color: Colors.grey[400]),
          inputDecoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        onSend: (ChatMessage m) {
          getChatGPTResponse(m);
        },
        messages: messages,
      ),
    );
  }

  Future<void> getChatGPTResponse(ChatMessage userMessage) async {
    setState(() {
      messages.insert(0, userMessage);
    });

    final typingMessage = ChatMessage(
      text: "جاري الكتابة...",
      user: chatgptUser,
      createdAt: DateTime.now(),
    );
    setState(() {
      messages.insert(0, typingMessage);
    });

    try {
      final chat = _model.startChat();

      final response = await chat.sendMessage(Content.text(userMessage.text));

      final responseText = response.text?.trim() ?? "عذرًا، لم أستطع فهم ذلك. حاول مرة أخرى.";

      setState(() {
        messages.removeAt(0);
        final chatResponse = ChatMessage(
          text: responseText,
          user: chatgptUser,
          createdAt: DateTime.now(),
        );
        messages.insert(0, chatResponse);
      });
    } catch (e) {
      setState(() {
        messages.removeAt(0);

        String errorMessageText;
        if (e.toString().contains('API key')) {
          errorMessageText = "خطأ: مفتاح API غير صالح. يرجى التحقق من المفتاح في الكود.";
        } else if (e.toString().contains('network')) {
          errorMessageText = "خطأ في الاتصال بالإنترنت. يرجى التحقق من اتصالك.";
        } else {
          errorMessageText = "حدث خطأ: ${e.toString()}";
        }

        final errorMessage = ChatMessage(
          text: errorMessageText,
          user: chatgptUser,
          createdAt: DateTime.now(),
        );
        messages.insert(0, errorMessage);
      });
      print("Error: $e");
    }
  }

  void clearChat() {
    setState(() {
      messages.clear();
    });
  }
}