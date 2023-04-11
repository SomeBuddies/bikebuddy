import 'package:bike_buddy/components/bb_appbar.dart';
import 'package:bike_buddy/components/custom_round_button.dart';
import 'package:bike_buddy/adapters/ride_item.dart';
import 'package:bike_buddy/pages/ride_details_page.dart';
import 'package:bike_buddy/services/timer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../services/locator.dart';

class RidePage extends StatefulWidget {
  const RidePage({super.key});

  static const String routeName = '/ride';

  @override
  State<RidePage> createState() => _RidePageState();
}

class _RidePageState extends State<RidePage> {
  bool isRideActive = true;

  late Timer timer;
  late Locator locator;

  String timerValue = "00:00:00";
  String currentPosition = "GPS does not work";

  @override
  void initState() {
    initializeTimer();
    initializeLocator();
    super.initState();
  }

  void initializeLocator() {
    locator = Locator(
      (currentPosition) => setState(() {
        this.currentPosition = currentPosition.toString();
      }),
    );
    locator.start();
  }

  void initializeTimer() {
    timer = Timer(
      (timerValue) => setState(() {
        this.timerValue = timerValue.toString();
      }),
    );
    timer.start();
  }

  void resumeButtonHandler() {
    setState(() {
      isRideActive = true;
    });
    timer.resume();
  }

  void pauseButtonHandler() {
    setState(() {
      isRideActive = false;
    });
    timer.pause();
  }

  void stopButtonHandler() {
    locator.stop();
    timer.stop();
    saveCurrentRide();

    Navigator.pushReplacementNamed(context, RideDetailsPage.routeName);
  }

  Future<void> saveCurrentRide() async {
    var rideItemsBox = Hive.box("ride_items");
    var rideItem = RideItem(locator, timer);
    await rideItemsBox.add(rideItem);
  }

  late final List<Widget> activeRideButtons = [
    CustomRoundButton.large(
      icon: const Icon(
        Icons.pause,
        size: 60,
      ),
      onPressed: pauseButtonHandler,
    ),
  ];

  late final List<Widget> inactiveRideButtons = [
    CustomRoundButton.large(
      backgroundColor: Colors.green,
      icon: const Icon(
        Icons.play_arrow,
        size: 60,
      ),
      onPressed: resumeButtonHandler,
    ),
    const SizedBox(width: 10),
    CustomRoundButton.medium(
      backgroundColor: Colors.redAccent,
      icon: const Icon(
        Icons.stop,
        size: 48,
      ),
      onPressed: () {},
      onLongPress: stopButtonHandler,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const BBAppBar.hideBackArrow(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/map.png"),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(timerValue),
                        const Text("420km"),
                        const Text("42.0"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        "69km/h",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 15,
                  child: Text(currentPosition),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomRoundButton.small(
                        icon: const Icon(
                          Icons.location_pin,
                          size: 25,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isRideActive == true
                        ? activeRideButtons
                        : inactiveRideButtons,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
