import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shady_task/data_layer/models/clinic_model.dart';
import 'package:shady_task/presentation_layer/widgets/clinic_form_widget/clinic_form_widget.dart';

part 'add_new_clinic_state.dart';

class AddNewClinicCubit extends Cubit<AddNewClinicState> {
  AddNewClinicCubit({required this.clinics}) : super(AddNewClinicInitial()) {
    clinicsWidgets = clinics.map((e) => ClinicFormWidget(clinic: e)).toList();
  }

  static AddNewClinicCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);
  final List<ClinicModel> clinics;
  late final List<ClinicFormWidget> clinicsWidgets;

  addNewClinic() {
    final clinicModel = ClinicModel();
    clinics.add(clinicModel);
    clinicsWidgets.add(ClinicFormWidget(clinic: clinicModel));
    emit(AddNewClinicSuccessState());
  }
}
