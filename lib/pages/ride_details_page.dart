import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RideDetailsPage extends StatefulWidget {
  const RideDetailsPage({Key? key}) : super(key: key);

  static const String routeName = '/ride-details';

  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var translations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: BBAppBar(),
      body: ListView(
        children: [
          Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(translations.h_ride_details,
                      style: TextStyle(fontSize: 30)))),
          Card(
            child: Text(
                "Lorem ipsum dolor sit amet,,\n\n\n consectetur adipiscing elit"),
          ),
          Card(
            child: Text(
                "Lorem ipsum dolor sit amet,,\n\n\n consectetur adipiscing elit,"),
          ),
          Card(
            child: Text(
                "Lorem ipsum dolor sit amet,,\n\n\n consectetur adipiscing elit,"),
          ),
        ],
      ),
    );
  }
}