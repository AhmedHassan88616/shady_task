import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shady_task/data_layer/models/user_model.dart';
import 'package:shady_task/data_layer/repository/user_repository.dart';

import '../../data_layer/models/clinic_model.dart';
import '../../shared/constants/constants.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final UserRepository _userRepository = UserRepository();

  void userSignUp({
    required UserModel user,
    required List<ClinicModel> clinics,
  }) {
    emit(SignUpLoadingState());
    _userRepository.userRegister(user: user, clinics: clinics).then((value) {
      showSuccessToast(successMessage: 'success');
      emit(SignUpSuccessState());
    }).catchError((error) {
      debugPrint('$error');
      showErrorToast(error: error);
      emit(
        SignUpErrorState(),
      );
    });
  }
}
