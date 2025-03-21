extension IntExtensions on int {
  // Thumbnails URLs
  //HybridShivam → Pokémon 001-904 (Generasi 1-8, resolusi kecil)
  //PokéAPI → Pokémon 905+ (Generasi 9 ke atas, lebih lengkap).
  String get thumbnailUrl {
    final stringNumber = toString();
    if (this < 905) {
      return 'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails/${stringNumber.padLeft(3, '0')}.png';
    }
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$stringNumber.png';
  }

  // Number
  String get pokenumber => '#${toString().padLeft(3, '0')}';

  // Gender
  double get femaleRate => (this / 8.0) * 100.0;
  double get maleRate => 100.0 - femaleRate;

  // Weight
  double get kg => this / 10.0;
  double get lb => (this / 10.0) * 2.20462;

  // Measurement
  double get meter => this / 10.0;
  int get cm => this * 10;
  String cmToFeedAndInches() {
    final inches = this * 0.393701;
    final feet = (inches / 12).floor();
    final remainingInches = (inches % 12).round();
    final feetAndInches = "$feet' $remainingInches\"";
    return feetAndInches;
  }

  // Status
  int get minHp => _calculateHp(this, 0, 0);
  int get maxHp => _calculateHp(this, 252, 31);
  int get minStatus => _calculateStatus(this, 0, 0, 100, 0.9);
  int get maxStatus => _calculateStatus(this, 252, 31, 100, 1.1);

  int _calculateHp(int base, int ev, int iv, [int level = 100]) {
    return ((0.01 * (2 * base + iv + (0.25 * ev)) * level) + level + 10)
        .toInt();
  }

  int _calculateStatus(
    int base,
    int ev,
    int iv, [
    int level = 100,
    double nature = 1.0,
  ]) {
    return (((0.01 * (2 * base + iv + (0.25 * ev)) * level) + 5) * nature)
        .toInt();
  }
}
