import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shady_task/business_logic_layer/date_picker_cubit/date_picker_cubit.dart';
import 'package:shady_task/business_logic_layer/expandable_cubit/expandable_cubit.dart';
import 'package:shady_task/business_logic_layer/get_file_cubit/get_file_cubit.dart';
import 'package:shady_task/business_logic_layer/radio_cubit/radio_cubit.dart';
import 'package:shady_task/business_logic_layer/sign_up_cubit/sign_up_cubit.dart';
import 'package:shady_task/business_logic_layer/user_cubit/user_cubit.dart';
import 'package:shady_task/data_layer/models/clinic_model.dart';
import 'package:shady_task/data_layer/models/user_model.dart';
import 'package:shady_task/presentation_layer/screens/settings/settings_screen.dart';
import 'package:shady_task/presentation_layer/widgets/medical_info_widget/medical_info_widget.dart';
import 'package:shady_task/presentation_layer/widgets/work_info_widget/work_info_widget.dart';
import 'package:shady_task/shared/components/default_button.dart';
import 'package:shady_task/shared/constants/constants.dart';

import '../../../business_logic_layer/add_new_clinic/add_new_clinic_cubit.dart';
import '../../../business_logic_layer/drop_down_cubit/drop_down_cubit.dart';
import '../../../business_logic_layer/localization_cubit/localization_cubit.dart';
import '../../../business_logic_layer/theme_cubit/theme_cubit.dart';
import '../../widgets/personal_info_widget/personal_info_widget.dart';
import '../main_page/main_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isExpanded = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserModel _userModel = UserModel();
  final List<ClinicModel> _clinics = [ClinicModel()];

  late PersonalInfoWidget _personalInfoWidget;
  late WorkInfoWidget _workInfoWidget;
  late MedicalInfoWidget _medicalInfoWidget;

  late final SignUpCubit _signUpCubit;
  late final UserCubit _userCubit;
  final ExpandableCubit _personalMedicalInfoCubit = ExpandableCubit();
  final ExpandableCubit _expandableMedicalInfoCubit = ExpandableCubit();
  final GetFileCubit _getVideoCubit = GetFileCubit();
  final GetFileCubit _getImageCubit = GetFileCubit();
  final DropDownCubit _mainSpecialityDropDownCubit = DropDownCubit();
  final DropDownCubit _scientificDegreesDropDownCubit = DropDownCubit();
  final ExpandableCubit _expandableWorkInfoCubit = ExpandableCubit();

  final DropDownCubit _regionDropDownCubit = DropDownCubit();
  final DropDownCubit _cityDropDownCubit = DropDownCubit();
  late final DropDownCubit _yourIDDropDownCubit;

  final RadioCubit _genderRadioCubit = RadioCubit();
  late final DatePickerCubit _datePickerCubit;
  late final AddNewClinicCubit _addNewClinicCubit;

  @override
  void initState() {
    super.initState();
    _signUpCubit = SignUpCubit.get(context);
    _userCubit = UserCubit.get(context);
    _yourIDDropDownCubit = DropDownCubit()..dropDownValue = 'Passport';
    _datePickerCubit = DatePickerCubit(
      selectedDate: DateTime.now().subtract(
        const Duration(
          days: 30,
        ),
      ),
    );
    _addNewClinicCubit = AddNewClinicCubit(clinics: _clinics);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    appLocalization = AppLocalizations.of(context);
    _personalInfoWidget = PersonalInfoWidget(
      userModel: _userModel,
      regionDropDownCubit: _regionDropDownCubit,
      cityDropDownCubit: _cityDropDownCubit,
      yourIDDropDownCubit: _yourIDDropDownCubit,
      genderRadioCubit: _genderRadioCubit,
      datePickerCubit: _datePickerCubit,
      expandablePersonalInfoCubit: _personalMedicalInfoCubit,
    );
    _medicalInfoWidget = MedicalInfoWidget(
      userModel: _userModel,
      expandableMedicalInfoCubit: _expandableMedicalInfoCubit,
      getVideoCubit: _getVideoCubit,
    );
    _workInfoWidget = WorkInfoWidget(
      userModel: _userModel,
      getImageCubit: _getImageCubit,
      mainSpecialityDropDownCubit: _mainSpecialityDropDownCubit,
      scientificDegreesDropDownCubit: _scientificDegreesDropDownCubit,
      expandableWorkInfoCubit: _expandableWorkInfoCubit,
      addNewClinicCubit: _addNewClinicCubit,
    );
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is SignUpSuccessState) {
                _userCubit.getUserData();
              }
            },
            builder: (context, state) {
              return BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is GetUserDataSuccessState) {
                    navigateAndFinishTo(context: context, screen: MainPage());
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                navigateTo(
                                    context: context, screen: SettingsScreen());
                              },
                              iconSize: 100.0,
                              icon: Column(
                                children: [
                                  Icon(
                                    Icons.settings,
                                    size: 35.0,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    '${appLocalization!.settings}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 200.0,
                            ),
                          ],
                        ),
                        _personalInfoWidget,
                        const SizedBox(
                          height: 10.0,
                        ),
                        _workInfoWidget,
                        const SizedBox(
                          height: 10.0,
                        ),
                        _medicalInfoWidget,
                        const SizedBox(
                          height: 30.0,
                        ),
                        DefaultButton(
                          function: () {
                            _submit();
                          },
                          text: '${appLocalization!.signUp}',
                          width: 120.0,
                          height: 40.0,
                          radius: 50.0,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )),
    );
  }

  _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_personalInfoWidget.submit() &&
        _workInfoWidget.submit() &&
        _medicalInfoWidget.submit()) {
      _signUpCubit.userSignUp(user: _userModel, clinics: _clinics);
    }
  }
}
