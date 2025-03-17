import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';

abstract class PokemonDetailRepository {
  const PokemonDetailRepository();
  ResultFuture<Pokemon> getPokemon(int id);
}
