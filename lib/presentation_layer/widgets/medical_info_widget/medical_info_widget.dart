import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shady_task/data_layer/models/user_model.dart';
import 'package:shady_task/presentation_layer/screens/recorder/recorder_screen.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/styles/colors.dart';

import '../../../business_logic_layer/expandable_cubit/expandable_cubit.dart';
import '../../../business_logic_layer/get_file_cubit/get_file_cubit.dart';
import '../../../business_logic_layer/localization_cubit/localization_cubit.dart';
import '../../../business_logic_layer/theme_cubit/theme_cubit.dart';
import '../expandable/expandable_tile_widget.dart';

class MedicalInfoWidget extends StatelessWidget {
  final UserModel userModel;
  final ExpandableCubit expandableMedicalInfoCubit;

  final GetFileCubit getVideoCubit;
  String? audioUrl;

  MedicalInfoWidget({
    Key? key,
    required this.userModel,
    required this.expandableMedicalInfoCubit,
    required this.getVideoCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    return ExpandableTileWidget(
      title: '${appLocalization!.medicalInfo}',
      controller: expandableMedicalInfoCubit,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '${appLocalization!.describeYourConditionByVideo}',
                    style: TextStyle(
                      color: defaultColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: BlocProvider(
                    create: (context) => getVideoCubit,
                    child: BlocConsumer<GetFileCubit, GetFileState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                getVideoCubit.getVideo();
                              },
                              icon: const Icon(
                                Icons.upload_outlined,
                                size: 25.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.videocam_sharp,
                              size: 25.0,
                              color: defaultColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '${appLocalization!.describeYourConditionByVoice}',
                    style: TextStyle(
                      color: defaultColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          audioUrl = null;
                          navigateTo(
                              context: context,
                              screen: AudioRecorderScreen(
                                  onUploadCompleted: (fileUrl) {
                                audioUrl = fileUrl;
                              }));
                        },
                        icon: const Icon(
                          Icons.upload_outlined,
                          size: 25.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.mic,
                        size: 25.0,
                        color: defaultColor,
                      ),
                    ],
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
    if (getVideoCubit.fileUrl == null || audioUrl == null) {
      showErrorToast(error: Exception(''));
      return false;
    }
    userModel.userVideo = getVideoCubit.fileUrl;
    userModel.userAudio = audioUrl;
    return true;
  }
}
