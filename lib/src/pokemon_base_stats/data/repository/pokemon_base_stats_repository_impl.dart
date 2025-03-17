import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/errors/exceptions.dart';
import 'package:pokedex_app/core/errors/failures.dart';
import 'package:pokedex_app/core/extensions/int_extension.dart';
import 'package:pokedex_app/core/extensions/type_extensions.dart';
import 'package:pokedex_app/core/utils/pair.dart';
import 'package:pokedex_app/core/utils/typedefs.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/entity/pokemon_base_stats_value_entity.dart';
import 'package:pokedex_app/src/pokemon_base_stats/domain/repository/pokemon_base_stats_repository.dart';

class PokemonBaseStatsRepositoryImpl implements PokemonBaseStatsRepository {
  PokemonBaseStatsRepositoryImpl(this._client);

  final Pokedex _client;

  @override
  ResultFuture<PokemonBaseStatsEntity> getBaseStats(Pokemon pokemon) async {
    try {
      final typesResources = await _client.types.getAll();
      final allTypes = typesResources.results.map((e) => e.name);

      final types = await Future.wait(
        pokemon.types.map((e) => _client.types.getByUrl(e.type.url)),
      );

      final damage = types.damageFrom;

      final statsMap = Map.fromEntries(
        pokemon.stats.map(
          (e) => MapEntry(
            e.stat.name,
            PokemonBaseStatsValueEntity(
              value: e.baseStat,
              minValue:
                  e.stat.name == 'hp' ? e.baseStat.minHp : e.baseStat.minStatus,
              maxValue:
                  e.stat.name == 'hp' ? e.baseStat.maxHp : e.baseStat.maxStatus,
            ),
          ),
        ),
      );

      damage.addAll(
        allTypes.whereNot(damage.containsKey).fold(
          <String, double>{},
          (previousValue, element) => previousValue..[element] = 1.0,
        ),
      );

      return Right(
        PokemonBaseStatsEntity(
          pokemon: pokemon,
          statsMap: statsMap,
          minStat: statsMap.values.map((e) => e.minValue).minOrNull ?? 0,
          summation: statsMap.values.map((e) => e.value).sum,
          multipliers: damage.entries
              .sorted((a, b) => a.value.compareTo(b.value))
              .whereNot((e) => ['unknown', 'shadow'].contains(e.key))
              .map((e) => Pair(e.key, e.value))
              .toList(),
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Unexpected error: $e', statusCode: 500),
      );
    }
  }
}
