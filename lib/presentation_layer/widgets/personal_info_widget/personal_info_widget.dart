import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shady_task/business_logic_layer/drop_down_cubit/drop_down_cubit.dart';
import 'package:shady_task/business_logic_layer/radio_cubit/radio_cubit.dart';
import 'package:shady_task/data_layer/models/user_model.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/styles/colors.dart';

import '../../../business_logic_layer/date_picker_cubit/date_picker_cubit.dart';
import '../../../business_logic_layer/expandable_cubit/expandable_cubit.dart';
import '../../../business_logic_layer/localization_cubit/localization_cubit.dart';
import '../../../business_logic_layer/theme_cubit/theme_cubit.dart';
import '../../../shared/components/default_text_form_field.dart';
import '../expandable/expandable_tile_widget.dart';

class PersonalInfoWidget extends StatelessWidget {
  final ExpandableCubit expandablePersonalInfoCubit;
  final UserModel userModel;

  PersonalInfoWidget({
    Key? key,
    required this.userModel,
    required this.genderRadioCubit,
    required this.cityDropDownCubit,
    required this.regionDropDownCubit,
    required this.yourIDDropDownCubit,
    required this.datePickerCubit,
    required this.expandablePersonalInfoCubit,
  }) : super(key: key);

  final RadioCubit genderRadioCubit;

  final DropDownCubit cityDropDownCubit;

  final DropDownCubit regionDropDownCubit;

  final DropDownCubit yourIDDropDownCubit;

  final DatePickerCubit datePickerCubit;

  final TextEditingController _fullNameTextEditingController =
      TextEditingController();
  final TextEditingController _dateOfBirthTextEditingController =
      TextEditingController();
  final TextEditingController _personalAddressTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    return ExpandableTileWidget(
      title: '${appLocalization!.personalInfo}',
      controller: expandablePersonalInfoCubit,
      children: [
        Column(
          children: [
            DefaultTextFormField(
              controller: _fullNameTextEditingController,
              type: TextInputType.text,
              label: '${appLocalization!.fullName}',
              validate: (String value) {
                if (value.trim().isEmpty) {
                  return 'Full name is required';
                }
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  '${appLocalization!.yourID}',
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    items: idTypes
                        .map(
                          (String e) => DropdownMenuItem<String>(
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    value: yourIDDropDownCubit.dropDownValue,
                    onChanged: (String? value) {
                      if (value != null) {
                        yourIDDropDownCubit.changeDropDownValue(value);
                      }
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'please select id type';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            BlocProvider(
              create: (context) => genderRadioCubit,
              child: BlocConsumer<RadioCubit, RadioState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: [
                        Text(
                          '${appLocalization!.gender}',
                          style: TextStyle(
                            color: defaultColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                              title: const Text('male'),
                              value: 'male',
                              groupValue: genderRadioCubit.radioValue,
                              activeColor: defaultColor,
                              onChanged: (String? value) {
                                if (value != null) {
                                  genderRadioCubit.changeRadioValue(value);
                                }
                              }),
                        ),
                        Expanded(
                          child: RadioListTile(
                              title: const Text('female'),
                              value: 'female',
                              groupValue: genderRadioCubit.radioValue,
                              activeColor: defaultColor,
                              onChanged: (String? value) {
                                if (value != null) {
                                  genderRadioCubit.changeRadioValue(value);
                                }
                              }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            BlocProvider(
              create: (context) => datePickerCubit,
              child: BlocConsumer<DatePickerCubit, DatePickerState>(
                listener: (context, state) {
                  // TODO: implement listener

                  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
                  _dateOfBirthTextEditingController.text =
                      dateFormat.format(datePickerCubit.selectedDate);
                },
                builder: (context, state) {
                  return DefaultTextFormField(
                    controller: _dateOfBirthTextEditingController,
                    type: TextInputType.datetime,
                    label: '${appLocalization!.dateOfBirth}',
                    isClickable: true,
                    onTap: () {
                      datePickerCubit.changeDate(
                        context: context,
                        firstDate: DateTime(
                          1900,
                        ),
                        lastDate: DateTime.now().subtract(
                          const Duration(
                            days: 30,
                          ),
                        ),
                      );
                    },
                    readOnly: true,
                    validate: (String value) {
                      if (value.trim().isEmpty) {
                        return 'birth of date is required';
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            DefaultTextFormField(
                controller: _personalAddressTextEditingController,
                type: TextInputType.text,
                label: '${appLocalization!.personalAddress}'),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  '${appLocalization!.city}',
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    items: cities
                        .map(
                          (String e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    value: cityDropDownCubit.dropDownValue,
                    hint: Text(
                      'select your city',
                      style: TextStyle(color: defaultColor),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        cityDropDownCubit.changeDropDownValue(value);
                      }
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'please select city';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  '${appLocalization!.region}',
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    items: regions
                        .map(
                          (String e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    value: regionDropDownCubit.dropDownValue,
                    hint: Text(
                      'select your region',
                      style: TextStyle(color: defaultColor),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        regionDropDownCubit.changeDropDownValue(value);
                      }
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'please select region';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            DefaultTextFormField(
              controller: _emailTextEditingController,
              type: TextInputType.emailAddress,
              label: '${appLocalization!.email}',
              validate: (String value) {
                if (value.trim().isEmpty) {
                  return 'email is required';
                }
                if (!value.trim().contains('@')) return 'email is not valid';
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            DefaultTextFormField(
              controller: _passwordTextEditingController,
              type: TextInputType.visiblePassword,
              isPassword: true,
              label: '${appLocalization!.password}',
              validate: (String value) {
                if (value.trim().isEmpty) {
                  return 'password is required';
                }
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
            DefaultTextFormField(
              controller: _cPasswordTextEditingController,
              type: TextInputType.visiblePassword,
              isPassword: true,
              label: '${appLocalization!.confirmPassword}',
              validate: (String value) {
                if (value.trim().isEmpty) {
                  return 'password is required';
                }
                if (value != _passwordTextEditingController.text) {
                  return 'password is not identical';
                }
              },
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        )
      ],
    );
  }

  bool submit() {
    if (genderRadioCubit.radioValue == null) {
      showErrorToast(error: Exception('please select gender'));
      return false;
    }
    userModel.fullName = _fullNameTextEditingController.text;
    userModel.idType = yourIDDropDownCubit.dropDownValue;
    userModel.birthDate = _dateOfBirthTextEditingController.text;
    userModel.personalAddress = _personalAddressTextEditingController.text;
    userModel.city = cityDropDownCubit.dropDownValue;
    userModel.region = regionDropDownCubit.dropDownValue;
    userModel.email = _emailTextEditingController.text;
    userModel.password = _passwordTextEditingController.text;
    userModel.gender = genderRadioCubit.radioValue;
    return true;
  }
}
