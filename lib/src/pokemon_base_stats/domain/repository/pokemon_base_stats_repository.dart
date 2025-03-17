import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';

abstract class PokemonBaseStatsRepository {
  const PokemonBaseStatsRepository();
  ResultFuture<PokemonBaseStatsEntity> getBaseStats(Pokemon pokemon);
}
