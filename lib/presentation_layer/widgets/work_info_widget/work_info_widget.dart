import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shady_task/business_logic_layer/add_new_clinic/add_new_clinic_cubit.dart';
import 'package:shady_task/business_logic_layer/drop_down_cubit/drop_down_cubit.dart';
import 'package:shady_task/data_layer/models/user_model.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/styles/colors.dart';

import '../../../business_logic_layer/expandable_cubit/expandable_cubit.dart';
import '../../../business_logic_layer/get_file_cubit/get_file_cubit.dart';
import '../../../business_logic_layer/localization_cubit/localization_cubit.dart';
import '../../../business_logic_layer/theme_cubit/theme_cubit.dart';
import '../expandable/expandable_tile_widget.dart';

class WorkInfoWidget extends StatelessWidget {
  final UserModel userModel;

  WorkInfoWidget({
    Key? key,
    required this.userModel,
    required this.expandableWorkInfoCubit,
    required this.getImageCubit,
    required this.mainSpecialityDropDownCubit,
    required this.scientificDegreesDropDownCubit,
    required this.addNewClinicCubit,
  }) : super(key: key);

  final ExpandableCubit expandableWorkInfoCubit;

  final GetFileCubit getImageCubit;

  final DropDownCubit mainSpecialityDropDownCubit;

  final DropDownCubit scientificDegreesDropDownCubit;

  final AddNewClinicCubit addNewClinicCubit;

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    return ExpandableTileWidget(
      title: '${appLocalization!.workInfo}',
      controller: expandableWorkInfoCubit,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Text(
                  '${appLocalization!.mainSpeciality}',
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
                    items: medicalSpecialties
                        .map(
                          (String e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    value: mainSpecialityDropDownCubit.dropDownValue,
                    hint: Text(
                      'select main speciality',
                      style: TextStyle(color: defaultColor),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        mainSpecialityDropDownCubit.changeDropDownValue(value);
                      }
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'please select main speciality';
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
                  '${appLocalization!.scientificDegrees}',
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
                    items: scientificDegrees
                        .map(
                          (String e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    value: scientificDegreesDropDownCubit.dropDownValue,
                    hint: Text(
                      'select degree',
                      style: TextStyle(color: defaultColor),
                    ),
                    onChanged: (String? value) {
                      if (value != null) {
                        scientificDegreesDropDownCubit
                            .changeDropDownValue(value);
                      }
                    },
                    validator: (String? value) {
                      if (value == null) {
                        return 'please select scientific degree';
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
              create: (context) => addNewClinicCubit,
              child: BlocConsumer<AddNewClinicCubit, AddNewClinicState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Column(
                        children: addNewClinicCubit.clinicsWidgets,
                      ),
                      InkWell(
                        onTap: () {
                          addNewClinicCubit.addNewClinic();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: defaultColor,
                              ),
                              padding: const EdgeInsets.all(2.0),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              '${appLocalization!.add}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${appLocalization!.uploadLicense}',
                  style: TextStyle(
                    color: defaultColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocProvider(
                  create: (context) => getImageCubit,
                  child: BlocConsumer<GetFileCubit, GetFileState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          getImageCubit.getImage();
                        },
                        icon: const Icon(
                          Icons.upload_outlined,
                          size: 25.0,
                          color: Colors.blueGrey,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  bool submit() {
    if (getImageCubit.fileUrl == null) {
      showErrorToast(error: Exception(''));
      return false;
    }
    for (var cWidget in addNewClinicCubit.clinicsWidgets) {
      cWidget.submit();
    }
    userModel.mainSpeciality = mainSpecialityDropDownCubit.dropDownValue;
    userModel.scientificDegree = scientificDegreesDropDownCubit.dropDownValue;
    userModel.licenseImage = getImageCubit.fileUrl;
    return true;
  }
}
