import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/Telegram/data/datasources/chatRemoteDataSource.dart';
import 'features/Telegram/data/repository/chatRepositoryImpl.dart';
import 'features/Telegram/domain/usecases/deleteChatUseCase.dart';
import 'features/Telegram/domain/usecases/getChatsUseCase.dart';
import 'features/Telegram/domain/usecases/searchChatsUseCase.dart';
import 'features/Telegram/presentation/bloc/chatBloc/blocEvent.dart';
import 'features/Telegram/presentation/bloc/chatBloc/chatBloc.dart';
import 'features/Telegram/presentation/pages/telegram_screen.dart';

void main() {
  final remoteDataSource = ChatRemoteDataSourceImpl();
  final repository = ChatRepositoryImpl(remoteDataSource: remoteDataSource);

  final getChatsUseCase = GetChatsUseCase(repository);
  final deleteChatUseCase = DeleteChatUseCase(repository);
  final searchChatsUseCase = SearchChatsUseCase(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(
            getChatsUseCase: getChatsUseCase,
            deleteChatUseCase: deleteChatUseCase,
            searchChatsUseCase: searchChatsUseCase,
          )..add(LoadChatsEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isPlatformDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? ThemeData.dark() : ThemeData.light();

    return ThemeProvider(
      initTheme: initTheme,
      builder: (_, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: ChatListScreen(),
        );
      },
    );
  }
}