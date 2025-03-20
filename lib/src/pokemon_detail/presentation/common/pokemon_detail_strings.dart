
abstract class PokemonDetailStrings {
  static const aboutTab = 'About';
  static const baseStatsTab = 'Base Stats';
  static const evolutionTab = 'Evolution';
  static const movesTab = 'Moves';
  /// Format Pokemon ID (e.g. #001)
  static String formatPokemonId(int id) => '#${id.toString().padLeft(3, '0')}';
}
