import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';

abstract class PokemonRepository {
  const PokemonRepository();
  ResultFuture<List<Pokemon>> getPokemons(int limit, int offset);
}
