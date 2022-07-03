import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shady_task/business_logic_layer/main_page_cubit/main_page_cubit.dart';

import '../../../business_logic_layer/localization_cubit/localization_cubit.dart';
import '../../../business_logic_layer/theme_cubit/theme_cubit.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  late MainPageCubit _mainPageCubit;

  @override
  Widget build(BuildContext context) {
    context.watch<LocalizationCubit>();
    context.watch<ThemeCubit>();
    _mainPageCubit = MainPageCubit.get(context);
    return BlocConsumer<MainPageCubit, MainPageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: _mainPageCubit
              .mainSubScreens[_mainPageCubit.bottomNavBarCurrentIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: SizedBox(
              height: 80.0,
              child: BottomNavigationBar(
                currentIndex: _mainPageCubit.bottomNavBarCurrentIndex,
                backgroundColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.white,
                selectedItemColor: const Color(0xfff9b723),
                onTap: (value) {
                  _mainPageCubit.changeNavigationBottomBarIndex(
                    value,
                  );
                },
                items: _mainPageCubit.bottomNavItems,
              ),
            ),
          ),
        );
      },
    );
  }
}
