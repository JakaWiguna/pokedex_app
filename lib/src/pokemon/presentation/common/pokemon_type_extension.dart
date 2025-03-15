import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/enums/pokedex_type_colors.dart';
import 'package:pokedex_app/core/extensions/string_extension.dart';

extension PokemonTypeExtensions on PokemonType {
  PokedexTypeColor get color => type.name.pokemonColor;
}
