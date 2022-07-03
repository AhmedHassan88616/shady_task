import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/network/local/prefs_helper.dart';
import 'package:shady_task/shared/styles/colors.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.isDark}) : super(ThemeInitial());

  static ThemeCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  bool isDark;

  void turnOnDarkMode() {
    PrefsHelper.putBoolean(key: isDarkKey, value: true).then(
      (value) {
        isDark = true;
        defaultColor = darkThemeColor;
        emit(ToggleThemeState());
      },
    ).catchError((error) {
      debugPrint('$error');
    });
  }

  void turnOffDarkMode() {
    PrefsHelper.putBoolean(key: isDarkKey, value: false).then(
      (value) {
        isDark = false;
        defaultColor = lightThemeColor;
        emit(ToggleThemeState());
      },
    ).catchError((error) {
      debugPrint('$error');
    });
  }
}
