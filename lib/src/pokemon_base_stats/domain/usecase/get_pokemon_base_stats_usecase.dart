import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/usecases/use_cases.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/repository/pokemon_base_stats_repository.dart';

class GetPokemonBaseStatsUseCase extends UseCaseWithParams<
    PokemonBaseStatsEntity, GetPokemonBaseStatsParams> {
  const GetPokemonBaseStatsUseCase(this._repo);

  final PokemonBaseStatsRepository _repo;

  @override
  ResultFuture<PokemonBaseStatsEntity> call(GetPokemonBaseStatsParams params) =>
      _repo.getBaseStats(params.pokemon);
}

class GetPokemonBaseStatsParams {
  GetPokemonBaseStatsParams({required this.pokemon});

  final Pokemon pokemon;
}
