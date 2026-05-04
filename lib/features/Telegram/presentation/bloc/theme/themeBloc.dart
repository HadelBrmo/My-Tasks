import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytasks/features/Telegram/presentation/bloc/theme/themeEvent.dart';
import 'package:mytasks/features/Telegram/presentation/bloc/theme/themeState.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(lightTheme)) {
    on<ToggleThemeEvent>((event, emit) {
      if (state.themeData.brightness == Brightness.light) {
        emit(ThemeState(darkTheme));
      } else {
        emit(ThemeState(lightTheme));
      }
    });
  }

  static final lightTheme = ThemeData(
    primaryColor: const Color(0xFF517DA2),
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color(0xFF212D3B),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1D2733),
  );
}