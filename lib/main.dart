import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shady_task/business_logic_layer/localization_cubit/localization_cubit.dart';
import 'package:shady_task/business_logic_layer/main_page_cubit/main_page_cubit.dart';
import 'package:shady_task/business_logic_layer/sign_up_cubit/sign_up_cubit.dart';
import 'package:shady_task/business_logic_layer/theme_cubit/theme_cubit.dart';
import 'package:shady_task/business_logic_layer/user_cubit/user_cubit.dart';
import 'package:shady_task/presentation_layer/screens/signup/signup_screen.dart';
import 'package:shady_task/shared/bloc_observer/bloc_server.dart';
import 'package:shady_task/shared/constants/constants.dart';
import 'package:shady_task/shared/network/local/prefs_helper.dart';
import 'package:shady_task/shared/styles/colors.dart';
import 'package:shady_task/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await PrefsHelper.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeCubit _themeCubit =
      ThemeCubit(isDark: PrefsHelper.getData(key: isDarkKey) ?? false);
  final LocalizationCubit _localizationCubit = LocalizationCubit(
    languageCode: PrefsHelper.getData(key: langCodeKey) ?? 'en',
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _themeCubit,
        ),
        BlocProvider(
          create: (context) => _localizationCubit,
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => MainPageCubit(),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {
          // TODO: implement listener
          if (_themeCubit.isDark) {
            defaultColor = darkThemeColor;
          } else {
            defaultColor = lightThemeColor;
          }
        },
        builder: (context, state) {
          return BlocConsumer<LocalizationCubit, LocalizationState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                locale: Locale(
                  _localizationCubit.languageCode,
                ),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                themeMode:
                    _themeCubit.isDark ? ThemeMode.dark : ThemeMode.light,
                darkTheme: darkTheme,
                theme: lightTheme,
                home: Builder(builder: (context) {
                  appLocalization = AppLocalizations.of(context);
                  return const SignupScreen();
                }),
              );
            },
          );
        },
      ),
    );
  }
}
