import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shady_task/presentation_layer/screens/settings/settings_screen.dart';

import '../../presentation_layer/screens/home/home_screen.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  late final mainSubScreens;

  MainPageCubit() : super(MainPageInitial()) {
    mainSubScreens = [
      HomeScreen(),
      SettingsScreen(
        showBack: false,
      ),
    ];
  }

  static MainPageCubit get(context, {bool listen = false}) =>
      BlocProvider.of(context, listen: listen);

  int bottomNavBarCurrentIndex = 0;

  changeNavigationBottomBarIndex(int value) {
    bottomNavBarCurrentIndex = value;
    emit(ChangeBottomNavBar());
  }

  // int homePageLevel = 0;

  // changeHomePageLevel(int value) {
  //   mainSubScreens.removeAt(0);
  //   if (value == 0) {
  //     mainSubScreens.insert(0, const HomePhoneScreen());
  //   } else if (value == 1) {
  //     mainSubScreens.insert(0, TopMarketsPhoneScreen());
  //   } else if (value == 2) {
  //     mainSubScreens.insert(0, MarketsPhoneScreen());
  //   } else {
  //     mainSubScreens.insert(0, SearchPhoneScreen());
  //   }
  //   homePageLevel = value;
  //   emit(ChangeHomePageLevel());
  // }

  final bottomNavItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'settings',
    ),
  ];
}
