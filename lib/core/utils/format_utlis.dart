String formatHeight(int meters) {
  final inches = meters * 39.3701;
  final feet = inches ~/ 12;
  final remainingInches = inches % 12;
  final formattedInches = remainingInches.toStringAsFixed(1);
  final centimeters = (meters / 10).toStringAsFixed(2);
  return '$feet\'$formattedInches" ($centimeters cm)';
}

/// **Format Weight (Kg & Lbs)**
String formatWeight(int hectograms) {
  final kg = hectograms / 10;
  final lbs = (kg * 2.20462).toStringAsFixed(1);

  return '$lbs lbs ($kg kg)';
}
