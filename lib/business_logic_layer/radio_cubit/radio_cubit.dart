import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(RadioInitial());

  static RadioCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  String? radioValue;

  changeRadioValue(String value) {
    radioValue = value;
    emit(ChangeRadioValueState());
  }
}
