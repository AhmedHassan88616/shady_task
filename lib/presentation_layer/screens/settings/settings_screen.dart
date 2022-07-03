import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shady_task/business_logic_layer/expandable_cubit/expandable_cubit.dart';
import 'package:shady_task/business_logic_layer/localization_cubit/localization_cubit.dart';
import 'package:shady_task/business_logic_layer/theme_cubit/theme_cubit.dart';
import 'package:shady_task/business_logic_layer/user_cubit/user_cubit.dart';
import 'package:shady_task/data_layer/models/user_model.dart';
import 'package:shady_task/shared/components/default_button.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/styles/colors.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/expandable/expandable_tile_widget.dart';

class SettingsScreen extends StatelessWidget {
  final bool showBack;

  SettingsScreen({Key? key, this.showBack = true}) : super(key: key);
  late LocalizationCubit _localizationCubit;

  final ExpandableCubit expandableProfileCubit = ExpandableCubit();
  late UserModel _user;

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    if (!showBack) {
      _user = UserCubit.get(context).appUser!;
    }
    _localizationCubit = LocalizationCubit.get(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${appLocalization!.settings}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              25.0,
            ),
            bottomRight: Radius.circular(
              25.0,
            ),
          ),
        ),
        leadingWidth: 150.0,
        leading: Row(
          children: [
            if (showBack)
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            if (showBack)
              Expanded(
                child: Text(
                  '${appLocalization!.back}',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${appLocalization!.darkMode}',
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Switch(
                        value: ThemeCubit.get(context).isDark,
                        onChanged: (value) {
                          if (value)
                            ThemeCubit.get(context).turnOnDarkMode();
                          else
                            ThemeCubit.get(context).turnOffDarkMode();
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${appLocalization!.language}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RadioListTile(
                        title: const FittedBox(
                            fit: BoxFit.scaleDown, child: Text('العربية')),
                        value: 'ar',
                        groupValue: _localizationCubit.languageCode,
                        activeColor: defaultColor,
                        onChanged: (String? value) {
                          if (value != null) {
                            _localizationCubit.changeLanguage(langCode: value);
                          }
                        }),
                    RadioListTile(
                        title: const FittedBox(
                            fit: BoxFit.scaleDown, child: Text('English')),
                        value: 'en',
                        groupValue: _localizationCubit.languageCode,
                        activeColor: defaultColor,
                        onChanged: (String? value) {
                          if (value != null) {
                            _localizationCubit.changeLanguage(langCode: value);
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              if (!showBack)
                ExpandableTileWidget(
                    title: '${appLocalization!.profile}',
                    controller: expandableProfileCubit,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.fullName} :    ${_user.fullName}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.yourIdType}:    ${_user.idType}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.gender}:    ${_user.gender}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.dateOfBirth}:    ${_user.birthDate}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.personalAddress}:    ${_user.personalAddress}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.city}:    ${_user.city}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.region}:    ${_user.region}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.email}:    ${_user.email}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.clinics}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _user.clinics!
                            .map((e) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${appLocalization!.clinicName}:${e.name}',
                                      style: TextStyle(
                                        color: defaultColor,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      '${appLocalization!.clinicAddress}:${e.address}',
                                      style: TextStyle(
                                        color: defaultColor,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Text(
                                      '${appLocalization!.clinicPhone}:${e.phone}',
                                      style: TextStyle(
                                        color: defaultColor,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    Divider(
                                      color: defaultColor,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${appLocalization!.licenseImage}',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Image.network(_user.licenseImage!,
                          errorBuilder: (_, __, ___) => Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.grey,
                              )),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${appLocalization!.userVideo}',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          DefaultButton(
                            function: () {
                              showVideoDialog(context);
                            },
                            text: '${appLocalization!.show}',
                            width: 80.0,
                            radius: 10.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'user Audio',
                            style: TextStyle(
                              color: defaultColor,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          DefaultButton(
                            function: () {
                              final player = AudioPlayer();
                              player.setUrl('${_user.userAudio}');
                              player.play();
                            },
                            text: 'play',
                            width: 80.0,
                            radius: 10.0,
                          ),
                        ],
                      ),
                    ]),
            ],
          )),
    );
  }

  showVideoDialog(context) async {
    VideoPlayerController videoPlayerController;
    Future<void> videoPlayerFuture;
    videoPlayerController =
        VideoPlayerController.network(_user.userVideo ?? ' ');
    videoPlayerFuture = videoPlayerController.initialize();
    videoPlayerController.setLooping(true);

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              FutureBuilder(
                future: videoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    videoPlayerController.play();
                    return AspectRatio(
                      aspectRatio: videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoPlayerController),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          );
        });
  }
}
