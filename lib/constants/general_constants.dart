import 'package:flutter/material.dart';

const List<String> SUPPORTED_DISTANCE_UNITS = ["kilometer", "mile"];

const List<String> SUPPORTED_WEIGHT_UNITS = ["kg"];

const int MIN_RIDER_WEIGHT = 20;
const int MAX_RIDER_WEIGHT = 200;

final ButtonStyle kSmallRoundButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(40, 40),
  shape: const CircleBorder(),
);

final ButtonStyle kMediumRoundButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(82, 82),
  shape: const CircleBorder(),
);

final ButtonStyle kLargeRoundButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(100, 100),
  shape: const CircleBorder(),
);

const double MET = 7.75; // wartosc okreslajaca srednia intensywnosc wysilku
const mean_Earth_radius = 6371008.8;