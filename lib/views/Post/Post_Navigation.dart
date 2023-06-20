import 'package:cargo/views/Post/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization/app_localizations.dart';
import '../../localization/localization_bloc.dart';
import '../../localization/localization_state.dart';
import '../../shared/constant.dart';
import '../Work/ActiveCargo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Posts.dart';
import 'histrory.dart';

class Post_BottomNav extends StatelessWidget {
  Post_BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, localeState) {
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
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: TabBarView(
                children: [
                  BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, localeState) {
                      return Posts(
                        localizations: AppLocalizations.of(context),
                      );
                    },
                  ),
                  BlocBuilder<LocaleBloc, LocaleState>(
                    builder: (context, localeState) {
                      return CargoHistory(
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
                            icon: Icon(Icons.add),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Post Cargo") ??
                                  "Post Cargo",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                            icon: Icon(Icons.history_edu),
                            child: Text(
                              AppLocalizations.of(context)
                                      ?.translate("Cargo History") ??
                                  "Cargo History",
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
