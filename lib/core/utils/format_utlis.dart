import 'package:pokedex_app/core/extensions/int_extension.dart';

String formatHeight(int decimeters) {
  final heightInCm = decimeters.cm;
  final feetAndInches = heightInCm.cmToFeedAndInches();
  final meters = decimeters.meter;
  return '$feetAndInches (${meters.toStringAsFixed(2)} m)';
}

String formatWeight(int hectograms) {
  final kg = hectograms.kg;
  final lbs = hectograms.lb;
  return '${lbs.toStringAsFixed(1)} lbs (${kg.toStringAsFixed(1)} kg)';
}
