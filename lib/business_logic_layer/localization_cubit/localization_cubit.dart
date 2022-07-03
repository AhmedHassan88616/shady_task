import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants/constants.dart';
import '../../shared/network/local/prefs_helper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit({required this.languageCode})
      : super(LocalizationInitial());

  static LocalizationCubit get(context, {bool listen = false}) {
    return BlocProvider.of(context, listen: listen);
  }

  String languageCode;

  void changeLanguage({required String langCode}) {
    PrefsHelper.saveData(key: langCodeKey, value: langCode).then(
      (value) {
        languageCode = langCode;
        emit(ChangeLanguageState());
      },
    ).catchError((error) {
      debugPrint('$error');
    });
  }
}
