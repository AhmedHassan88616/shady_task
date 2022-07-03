import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'drop_down_state.dart';

class DropDownCubit extends Cubit<DropDownState> {
  DropDownCubit() : super(DropDownInitial());
  static DropDownCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  String? dropDownValue;

  changeDropDownValue(String value) {
    dropDownValue = value;
    emit(ChangeDropDownValueState());
  }
}
