// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../localization/app_localizations.dart';
import '../../localization/localization_bloc.dart';
import '../../localization/localization_state.dart';
import '../../shared/constant.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'AcceptedCargo.dart';
import 'Active.dart';
import 'FinishedCargo.dart';

class Work_BottomNav extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Work_BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, localeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const[
             Locale('en', ''),
             Locale('am', ''),
          ],
          locale: localeState.locale,
          home: DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: TabBarView(
                children: [
                  BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, localeState) {
                      return ActiveCargo(
                        localizations: AppLocalizations.of(context),
                      );
                    },
                  ),
                  BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, localeState) {
                      return AcceptedCargo(
                        localizations: AppLocalizations.of(context),
                      );
                    },
                  ),
                  BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, localeState) {
                      return FinishedCargo(
                        localizations: AppLocalizations.of(context),
                      );
                    },
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                height: screenHeight * 0.1,
                decoration: const BoxDecoration(color: kPrimaryColor),
                child: Container(
                  width: screenWidth,
                  child: Center(
                    child: TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: EdgeInsets.all(12),
                        indicatorColor: Colors.white,
                        isScrollable: false,
                        indicatorWeight: 3,
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.055),
                        tabs: [
                          Tab(
                            icon: Icon(Icons.remove_circle_outline),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Active") ??
                                  "Active",
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                            icon: Icon(Icons.thumb_up),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Accepted") ??
                                  "Accepted",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                            icon: Icon(Icons.verified),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate(" Finished") ??
                                  "Finished",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
