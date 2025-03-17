import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_about/domain/entity/pokemon_about_entity.dart';

abstract class PokemonAboutRepository {
  const PokemonAboutRepository();
  ResultFuture<PokemonAboutEntity> getPokemonAbout(Pokemon pokemon);
}
