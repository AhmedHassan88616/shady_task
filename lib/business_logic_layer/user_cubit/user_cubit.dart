import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/models/user_model.dart';
import '../../data_layer/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  UserModel? appUser;

  getUserData() {
    emit(GetUserDataLoadingState());
    _userRepository.getUser().then((value) {
      appUser = value;
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      debugPrint('$error');
      emit(GetUserDataErrorState());
    });
  }
}
