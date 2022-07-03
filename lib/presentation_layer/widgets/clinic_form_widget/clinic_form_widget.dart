import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shady_task/business_logic_layer/localization_cubit/localization_cubit.dart';
import 'package:shady_task/data_layer/models/clinic_model.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/styles/colors.dart';

import '../../../business_logic_layer/theme_cubit/theme_cubit.dart';
import '../../../shared/components/default_text_form_field.dart';

class ClinicFormWidget extends StatelessWidget {
  final ClinicModel clinic;

  ClinicFormWidget({
    Key? key,
    required this.clinic,
  }) : super(key: key);
  final TextEditingController _nameTextEditingController =
      TextEditingController();

  final TextEditingController _addressTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    return Column(
      children: [
        DefaultTextFormField(
          controller: _nameTextEditingController,
          type: TextInputType.text,
          label: '${appLocalization!.clinicName}',
          validate: (String value) {
            if (value.trim().isEmpty) {
              return 'Clinic name is required';
            }
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        DefaultTextFormField(
          controller: _addressTextEditingController,
          type: TextInputType.text,
          label: '${appLocalization!.clinicAddress}',
          validate: (value) {
            if (value.trim().isEmpty) {
              return 'Clinic address is required';
            }
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        DefaultTextFormField(
          controller: _phoneTextEditingController,
          type: TextInputType.phone,
          label: '${appLocalization!.clinicPhone}',
          validate: (String value) {
            if (value.trim().isEmpty) {
              return 'phone is required';
            }
          },
        ),
        const SizedBox(
          height: 10.0,
        ),
        Divider(
          color: defaultColor,
          thickness: 1.0,
        ),
      ],
    );
  }

  submit() {
    clinic.name = _nameTextEditingController.text.trim();
    clinic.address = _addressTextEditingController.text.trim();
    clinic.phone = _phoneTextEditingController.text.trim();
  }
}
