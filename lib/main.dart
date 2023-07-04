import 'package:cargo/views/Bottom_Navigation.dart';
import 'package:cargo/views/usermanagement/Profile.dart';
import 'package:cargo/views/usermanagement/login.dart';
import 'package:cargo/views/usermanagement/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'Components/Home_Page.dart';
import 'localization/app_localizations.dart';
import 'localization/localization_bloc.dart';
import 'localization/localization_event.dart';
import 'localization/localization_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'navigate/mainNavigation.dart';
import 'navigate/navigateBloc.dart';
import 'navigate/navigatestateEvent.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    builder: (context, child) {
      return ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: child!,
      );
    },
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LocaleBloc _localeBloc;
  late NavigationBloc _navigationBloc;

  @override
  void initState() {
    super.initState();
    _localeBloc = LocaleBloc();
    _navigationBloc = NavigationBloc();
    _localeBloc.stream.listen((state) => setState(() {}));
  }

  @override
  void dispose() {
    _localeBloc.close();
    _navigationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleBloc>.value(value: _localeBloc),
        BlocProvider<NavigationBloc>.value(value: _navigationBloc),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, localeState) {
          return BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, navigationState) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en', ''),
                  const Locale('am', ''),
                ],
                locale: localeState.locale,
                home: Scaffold(
                  body:
                      Profile(), // Place Cargo_login under the Provider<LocaleBloc>
                ),
              );
            },
          );
        },
      ),
    );
  }
}
