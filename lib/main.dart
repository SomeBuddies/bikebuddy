import 'package:bike_buddy/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:bike_buddy/pages/main_page.dart';
import 'package:bike_buddy/pages/ride_page.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:bike_buddy/pages/trip_history.dart';
import 'package:bike_buddy/pages/user_page.dart';
import 'package:bike_buddy/pages/settings/settings_page.dart';
import 'package:bike_buddy/pages/settings/settings_screen_notifier.dart';

import '/utils/l10n/l10n.dart';

void main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();

  runApp(ChangeNotifierProvider(
    create: (context) => SettingsScreenNotifier(),
    child: const BikeBuddy(),
  ));
}

class BikeBuddy extends StatelessWidget {
  const BikeBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsScreenNotifier>(
        builder: (context, notifier, child) {
      return MaterialApp(
        title: 'BikeBuddy',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        themeMode:
            notifier.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        routes: {
          '/': (context) => const MainPage(),
          RidePage.routeName: (context) => const RidePage(),
          UserPage.routeName: (context) => const UserPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          TripHistoryPage.routeName: (context) => const TripHistoryPage(),
          RideDetailsPage.routeName: (context) => const RideDetailsPage(),
        },
        supportedLocales: L10n.all,
        locale: Locale(notifier.applicationLanguage),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      );
    });
  }
}
