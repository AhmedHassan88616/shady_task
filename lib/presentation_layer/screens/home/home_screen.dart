import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shady_task/business_logic_layer/localization_cubit/localization_cubit.dart';
import 'package:shady_task/business_logic_layer/theme_cubit/theme_cubit.dart';
import 'package:shady_task/business_logic_layer/user_cubit/user_cubit.dart';
import 'package:shady_task/data_layer/models/user_model.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/styles/colors.dart';

import '../../../shared/utils/background_wave_clipper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late UserModel _user;

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();

    _user = UserCubit.get(context).appUser!;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              ClipPath(
                clipper: BackgroundWaveClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  color: defaultColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            appLocalization!.home,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const ImageIcon(
                            AssetImage("assets/images/icon-3.png"),
                            color: Colors.white,
                            size: 100.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, bottom: 100.0),
                child: Text(
                  '${appLocalization!.hi}, ${_user.fullName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            itemBuilder: (context, index) => Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage("assets/images/${homeCards[index]['icon']}.png"),
                    color: defaultColor,
                    size: 80.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    homeCards[index]['title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            itemCount: homeCards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 30.0,
            ),
          )
        ],
      ),
    ));
  }

  List<Map> homeCards = const [
    {'title': 'Dashboard', 'icon': 'icon-1'},
    {'title': 'OVR', 'icon': 'icon-2'},
    {'title': 'Staff risk', 'icon': 'icon-3'},
    {'title': 'Clinical & Non-Clinical', 'icon': 'icon-4'},
    {'title': 'KPIS', 'icon': 'icon-5'},
    {'title': 'PCRA', 'icon': 'icon-6'},
    {'title': 'Dashboard', 'icon': 'icon-7'},
  ];
}
